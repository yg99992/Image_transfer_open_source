/*
 * Image_transfer.c
 *
 *  Created on: 2020Äê4ÔÂ29ÈÕ
 *      Author: Chongchong Xu
 */
#include <stdio.h>
#include "math.h"
#include <ctype.h>
#include <stdlib.h>
#include "xil_types.h"
#include "xil_cache.h"
#include "xparameters.h"
#include "xiicps.h"
//#include "xgpio.h"
#include "sleep.h"
#include "xscugic.h"
#include "image_sensor.h"

#include "lwip/err.h"
#include "lwip/tcp.h"
#if defined (__arm__) || defined (__aarch64__)
#include "xil_printf.h"
#endif



#define DEMO_MAX_FRAME (128*128)
#define OUT_CNT (64)
#define ERR_LOOP_THR   		(0x0006000)
#define ERR_LOOP_THR_S 		(0x000200)
#define ERR_LOOP_THR_OUTS 	(0x000200)

image_sensor* IMAGE_CORE = (image_sensor *) XPAR_IMAGE_CTL_0_S00_AXI_BASEADDR;
u8  SEND_EN = 0;
int8_t ImageBuf[2][DEMO_MAX_FRAME] __attribute__ ((aligned(64)));
u64 ImageOutBuf[2][4 * OUT_CNT] __attribute__ ((aligned(64)));
u16 PodOutBuf[16 * OUT_CNT] __attribute__ ((aligned(64)));

image_sensor image_sta;

// bit0: start_up signal
// bit1: 0->Normal mode, 1->test mode
// bit2-7: switch0-5
u16 test_mod = 1;
u16 switch0  = 0;
u16 switch1  = 0;
u16 switch2  = 0;
u16 switch3  = 0;
u16 switch4  = 1;
u16 switch5  = 0;

u16 image_ctl = 0;

//exposure time: bit9-0 is connected with Expo_T_SW[9:0]
u16 image_exposure_time = 100;

//Time_Framedone_Cstart signal
u32 image_interval_time = 100;  //the interval time between two consequent time, default is 1000 * 0.1us

int sensor_init()
{
	image_ctl = (switch5 << 7) | (switch4 << 6) | (switch3 << 5) | (switch2 << 4) | (switch1 << 3) | (switch0 << 2) | (test_mod << 1);

	IMAGE_CORE->exposure_time = 1;
	IMAGE_CORE->exposure_time_out = 1;

	IMAGE_CORE->con0 = image_ctl;
	IMAGE_CORE->con0 = image_ctl | 0x01;  //start sensor simulator
	clear_all_soft_flag();

	return 0;
}

int clear_all_soft_flag(){
	int temp;
	temp 	= IMAGE_CORE->Cstart;
	temp    = temp + IMAGE_CORE->frame_down;
	temp    = temp + IMAGE_CORE->out_word1;
	temp    = temp + IMAGE_CORE->out_pod_w1;
	temp    = temp + IMAGE_CORE->pod3to0;
	return temp;
}

int read_out_data()
{
	int pixel_num = 0;
	u32 a0 = 0, a1=0, a2=0, a3=0, a4 = 0, a5=0, a6=0, a7=0;
	u32 out_pod[8] = {0};
	int error_cnt = 0;
	int temp_index;

	//while(IMAGE_CORE->Cstart == 0);  // wait Cstart signal

	while(!(IMAGE_CORE->out_en & 0x02)){   //Wait EN_data_out signal
		error_cnt ++;
		if(error_cnt > ERR_LOOP_THR)
			return 13;
	}
	error_cnt = 0;

	for(pixel_num = 0; pixel_num < OUT_CNT; ){
		//Wait EN_data_out signal
		while(!(IMAGE_CORE->out_en & 0x02)){
			error_cnt ++;
			if(error_cnt > ERR_LOOP_THR_OUTS)
				return 3;
		}
		error_cnt = 0;
		// FPGA data
		a0 = IMAGE_CORE->out_word1;
		a1 = IMAGE_CORE->out_word2;
		a2 = IMAGE_CORE->out_word3;
		a3 = IMAGE_CORE->out_word4;
		a4 = IMAGE_CORE->out_word5;
		a5 = IMAGE_CORE->out_word6;
		a6 = IMAGE_CORE->out_word7;
		a7 = IMAGE_CORE->out_word8;
		temp_index = pixel_num << 2;
		ImageOutBuf[0][temp_index + 0] 	= ((u64)a1 << 32) | (a0); // OUTR
		ImageOutBuf[0][temp_index + 1] 	= ((u64)a3 << 32) | (a2); // OUTL
		ImageOutBuf[0][temp_index + 2]	= ((u64)a5 << 32) | (a4); // OUTU
		ImageOutBuf[0][temp_index + 3]	= ((u64)a7 << 32) | (a6); // OUTD

		//Wait EN_out_pod signal
		while(!(IMAGE_CORE->out_en & 0x04)){
			error_cnt ++;
			if(error_cnt > ERR_LOOP_THR_OUTS)
				return 4;
		}
		error_cnt = 0;

		// pod out data
		out_pod[0] = IMAGE_CORE->out_pod_w1;
		out_pod[1] = IMAGE_CORE->out_pod_w2;
		out_pod[2] = IMAGE_CORE->out_pod_w3;
		out_pod[3] = IMAGE_CORE->out_pod_w4;
		out_pod[4] = IMAGE_CORE->out_pod_w5;
		out_pod[5] = IMAGE_CORE->out_pod_w6;
		out_pod[6] = IMAGE_CORE->out_pod_w7;
		out_pod[7] = IMAGE_CORE->out_pod_w8;

		temp_index = pixel_num << 4;
		*(int *)(PodOutBuf + temp_index + 0)  = out_pod[0];
		*(int *)(PodOutBuf + temp_index + 2)  = out_pod[1];
		*(int *)(PodOutBuf + temp_index + 4)  = out_pod[2];
		*(int *)(PodOutBuf + temp_index + 6)  = out_pod[3];
		*(int *)(PodOutBuf + temp_index + 8)  = out_pod[4];
		*(int *)(PodOutBuf + temp_index + 10) = out_pod[5];
		*(int *)(PodOutBuf + temp_index + 12) = out_pod[6];
		*(int *)(PodOutBuf + temp_index + 14) = out_pod[7];

		pixel_num ++;

	}
	return 0;
}

/* ------------------------------------------------------------ */
/*				Read data from Image sensor						*/
/* ------------------------------------------------------------ */
int read_image_data()
{
	int pixel_num = 0;
	unsigned int error_cnt = 0;
	int res;
	u32 a0 = 0, a1=0, a2=0, a3=0;

	//sensor_init();
	clear_all_soft_flag();

	for(pixel_num = 0; pixel_num < DEMO_MAX_FRAME; ){
		if(IMAGE_CORE->con0 & 0x00010000){ // wait En_Data_Pod signal
			a0 = IMAGE_CORE->pod3to0;
			a1 = IMAGE_CORE->pod7to4;
			a2 = IMAGE_CORE->pod11to8;
			a3 = IMAGE_CORE->pod15to12;

			*(int *)(ImageBuf[0]+pixel_num) 	= a0; //change 32bit data into 4 8bit data
			*(int *)(ImageBuf[0]+pixel_num+4) 	= a1;
			*(int *)(ImageBuf[0]+pixel_num+8) 	= a2;
			*(int *)(ImageBuf[0]+pixel_num+12) 	= a3;
			pixel_num +=16;   // As we could read 16 byte data, here 16 should be added each time
			error_cnt = 0;
		}else{
			error_cnt ++;
			if(error_cnt > ERR_LOOP_THR_S)
				return 1;
		}
	}
	clear_all_soft_flag();
	error_cnt = 0;

	while(!(IMAGE_CORE->con0 & 0x00010000)){  //wait pod_en signal
		error_cnt ++;
		if(error_cnt > (ERR_LOOP_THR))
			return 12;
	};
	error_cnt = 0;

	for(pixel_num = 0; pixel_num < DEMO_MAX_FRAME; ){
		if(IMAGE_CORE->con0 & 0x00010000){ // wait pod_en signal
			a0 = IMAGE_CORE->pod3to0;
			a1 = IMAGE_CORE->pod7to4;
			a2 = IMAGE_CORE->pod11to8;
			a3 = IMAGE_CORE->pod15to12;

			*(int *)(ImageBuf[1]+pixel_num) 	= a0; //change 32bit data into 4 8bit data
			*(int *)(ImageBuf[1]+pixel_num+4) 	= a1;
			*(int *)(ImageBuf[1]+pixel_num+8) 	= a2;
			*(int *)(ImageBuf[1]+pixel_num+12) 	= a3;
			pixel_num +=16;
			error_cnt = 0;
		}else{
			error_cnt ++;
			if(error_cnt > ERR_LOOP_THR_S)
				return 2;
		}
	}
	clear_all_soft_flag();

	res = read_out_data();
	if(res){
		return res;
	}


	IMAGE_CORE->con0 = image_ctl;  //stop sensor simulator
	return 0;
}

/*
int read_image_data_v2()
{
	int pixel_num = 0, i =0;
	int a0 = 0, a1=0, a2=0, a3=0;

	while(!IMAGE_CORE->reserve8){
		if(pixel_num < 2*DEMO_MAX_FRAME){
			i = (pixel_num >>15);
			while(IMAGE_CORE->con0 & 0x00010000){
				a0 = IMAGE_CORE->pod3to0;
				a1 = IMAGE_CORE->pod7to4;
				a2 = IMAGE_CORE->pod11to8;
				a3 = IMAGE_CORE->pod15to12;

				*(int *)(ImageBuf[i]+pixel_num) 	= a0; //change 32bit data into 4 8bit datas
				*(int *)(ImageBuf[i]+pixel_num+4) 	= a1;
				*(int *)(ImageBuf[i]+pixel_num+8) 	= a2;
				*(int *)(ImageBuf[i]+pixel_num+12) 	= a3;
				pixel_num +=16;
			}
		}
	}

	if(pixel_num >= 2*DEMO_MAX_FRAME)
		return 0;
	else
		return -1;
}*/

//struct tcp_pcb TPCB;
int trans_image_data(struct tcp_pcb *pcb)
{
	int i;
	int frame_num;
	int res;
	unsigned char cmd_send[2] = {0};
	//u8 ResBuf[DEMO_MAX_FRAME];

	cmd_send[0] = 0x55;
//	sensor_init();
	if(SEND_EN){
		//FUNC_SENSOR_START;
		res = read_image_data();
		cmd_send[1] = res;
		if(!res){  // the image data are read successfully !
			/*
			for(i=0; i<DEMO_MAX_FRAME; i++){   // SUB the data before and after exposure to get the real image data
				ResBuf[i] = ImageBuf[1][i] - ImageBuf[0][i];
				//ResBuf[i] = 255 - ImageBuf[1][i];
			}*/
			tcp_write(pcb, (const char *)(cmd_send), sizeof(cmd_send), 1);
			//tcp_output(pcb);

			tcp_write(pcb, (const char *)(ImageBuf[0]), DEMO_MAX_FRAME, 1);
			tcp_output(pcb);

			tcp_write(pcb, (const char *)(ImageBuf[1]), DEMO_MAX_FRAME, 1);
			tcp_output(pcb);

			tcp_write(pcb, (const char *)(ImageOutBuf[0]), sizeof(ImageOutBuf[0]), 1);
			//tcp_write(pcb, (const char *)(ImageOutBuf[1]), sizeof(ImageOutBuf[1]), 1);
			tcp_write(pcb, (const char *)(PodOutBuf), sizeof(PodOutBuf), 1);

			tcp_output(pcb);
		}
		else{
				xil_printf("Frame lost !!! \t");
				xil_printf("ERROR Code:\t %d \n\r", res);
				tcp_write(pcb, (const char *)(cmd_send), sizeof(cmd_send), 1);
				tcp_output(pcb);
		}

		//FUNC_SENSOR_STOP; // start image sensor
	}
	return 0;
}

int recv_process(struct tcp_pcb *tpcb, struct pbuf *p_rx)
{
	char *pData;
	char buff[10];
	if(p_rx != NULL)
	{
		pData = (char *)p_rx->payload;

		if(p_rx->len >= 2)
		{
			/* Check received data if they are query command from PC, format as random&0xFE, 0x00, 0x02, 0x00, 0x01 */
			if(pData[0] == 0x55)
			{
				/* Reply data, 16 bytes, random|0x01, 0x00, 0x02, 0x00, 0x01, mac_address, ip_address, 0x02 */
				if(pData[1] == 1)  // Enquire status
				{
					buff[0] = 0xaa;   // header
					buff[1] = 0xF1;   // command
					buff[2] = IMAGE_CORE->con0;   		// config low
					buff[3] = IMAGE_CORE->con0 >> 16;   // config high
					buff[4] = IMAGE_CORE->exposure_time;   		// exposure time low
					buff[5] = IMAGE_CORE->exposure_time >> 16;  // exposure time high
					buff[6] = IMAGE_CORE->interval_time;		// interval time low
					buff[7]	= IMAGE_CORE->interval_time >> 16;	// interval time high
					tcp_write(tpcb, buff, sizeof(buff), 1);
				}
				/* If received data is (random&0xFE, 0x00, 0x02, 0x00, 0x02, mac_address, ch_sel, flag) means PC request video data*/
				else if(pData[1] == 2)  // start send data
				{
					SEND_EN = 1;   		 // start image transfer
					trans_image_data(tpcb);
					//TPCB = *tpcb;
				}
				else if(pData[1] == 3)  // stop send data
				{
					buff[0] = 0xaa;		// header
					buff[1] = 0xF3;		// command
					SEND_EN = 0;	// stop image transfer
					tcp_write(tpcb, buff, 2, 1);
				}
				else if((pData[1] == 4) && p_rx->len >= 8)  // set mode
				{
					buff[0] = 0xaa;		// header
					buff[1] = 0xF4;		// command
					IMAGE_CORE->con0 			= (pData[3] << 16) | pData[2];	// set config
					IMAGE_CORE->exposure_time 	= (pData[5] << 16) | pData[4];
					IMAGE_CORE->interval_time	= (pData[7] << 16) | pData[6];
					tcp_write(tpcb, buff, 2, 1);
				}
			}
		}
	}
	return 0;
}

int init_image_sensor()
{

	IMAGE_CORE->exposure_time = image_exposure_time;
	IMAGE_CORE->interval_time = image_interval_time;
	IMAGE_CORE->con0		  = image_ctl;
	sensor_init();
	//FUNC_SENSOR_START; // start image sensor
	return 0;
}
