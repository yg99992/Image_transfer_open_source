/*
 * image_sensor.h
 *
 *  Created on: 2020Äê4ÔÂ27ÈÕ
 *      Author: Chongchong Xu
 */

#ifndef SRC_IMAGE_SENSOR_H_
#define SRC_IMAGE_SENSOR_H_

#include "lwip/tcp.h"

#define FUNC_SENSOR_START (IMAGE_CORE->con0 = IMAGE_CORE->con0 | 0x01)
#define FUNC_SENSOR_STOP  (IMAGE_CORE->con0 = IMAGE_CORE->con0 & 0xfe)

typedef struct {
	u32 con0;	/**< bit 0: start; bit 1: test_mod; bit 2-5: switch 0-3; */
	u32 exposure_time;	/**  */
	u32 interval_time;		/** */
	u32 exposure_time_out;   	/**reserve */
	u32 pod3to0;		/**reserve */
	u32 pod7to4;		/* */
	u32 pod11to8;		/* */
	u32 pod15to12;		/* */
	u32 frame_down;    /**reserve */
	u32 Cstart;    /**reserve */
	u32 out_word1;   /**reserve */
	u32 out_word2;   /**reserve */
	u32 out_word3;   /**reserve */
	u32 out_word4;   /**reserve */
	u32 out_word5;   /**reserve */
	u32 out_word6;   /**reserve */
	u32 out_word7;   /**reserve */
	u32 out_word8;   /**reserve */
	u32 out_en;   /**reserve */
	u32 out_pod_w1;   /**reserve */
	u32 out_pod_w2;   /**reserve */
	u32 out_pod_w3;   /**reserve */
	u32 out_pod_w4;   /**reserve */
	u32 out_pod_w5;   /**reserve */
	u32 out_pod_w6;   /**reserve */
	u32 out_pod_w7;   /**reserve */
	u32 out_pod_w8;   /**reserve */
} image_sensor;

int read_image_data();
int trans_image_data(struct tcp_pcb *pcb);
int recv_process(struct tcp_pcb *tpcb, struct pbuf *p_rx);
int init_image_sensor();
int clear_all_soft_flag();

#endif /* SRC_IMAGE_SENSOR_H_ */
