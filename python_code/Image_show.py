"""Display image captured from image sensor"""
import numpy as np
import cv2
import socket
import tkinter
import pandas as pd
import datetime
import time
import os


class ImageGUI(object):
    def __init__(self):
        #self.buffer_size = 128 * 128 * 3  # picture size
        self.buffer_size = (16384 * 2 + 2048 * 2)  # picture size
        self.img_buf_index = 0
        self.img_buf_size  = 3
        self.img_buf = np.array([[[0] * 128] * 128] * self.img_buf_size)
        self.array_buf = np.array([[0]*(128*128)]*3)
        self.array_out_buf   = np.array([[0]*(4*8*64)]*2)
        self.array_out_shape = np.array([[[0] * 64] * 32] * 2)
        self.array_pod_out = np.array([[0] * 64] * 32)


        # udp must send bytes object
        self.enquire_command    = bytes([int('0x55', 16), 1])  # 0x55, 0x01
        self.start_command      = bytes([int('0x55', 16), 2])
        self.stop_command       = bytes([int('0x55', 16), 3])
        self.stop_reply         = bytes([int('0xaa', 16), int('0xf3', 16)])

        # 创建主窗口,用于容纳其它组件
        self.root = tkinter.Tk()
        # 给主窗口设置标题内容
        self.root.title("University of Macau AMSV Image Sensor Control")
        self.root.geometry('500x300')

        # 创建一个输入框,并设置尺寸
        self.input_ip = tkinter.Entry(self.root,width=50)

        # 创建一个回显列表
        self.display_info = tkinter.Listbox(self.root, width=50)

        # 创建按钮
        #self.result_button = tkinter.Button(self.root, command = self.find_position, text = "查询")
        self.connect_button     = tkinter.Button(self.root, command = self.connect_fun, text = "Connect")
        self.image_start_button = tkinter.Button(self.root, command = self.trans_start, text = "Start")
        self.image_stop_button  = tkinter.Button(self.root, command = self.image_save_stop, text = "Save")

    # 完成布局
    def gui_arrang(self):
        self.input_ip.pack()
        self.connect_button.place(x=100,y=220,height=50,width=100)
        self.image_start_button.place(x=200,y=220,height=50,width=100)
        self.image_stop_button.place(x=300,y=220,height=50,width=100)
        self.display_info.pack()
    
    def connect_fun(self, print_en = 1):
        self.ip_addr = self.input_ip.get()
        self.udp_server_ip_addr = self.ip_addr  # target IP address
        self.udp_port = 7                       # port
        self.soc=socket.socket()
        self.soc.connect((self.udp_server_ip_addr, self.udp_port))

        if(print_en == 1):
            self.display_info.insert(0,"Connect successfully")
            self.soc.close()

    def trans_start(self):  # This function will be executed when 'Start' button is clicked
        ## 为回显列表赋值
        #self.display_info.insert(0,input_str)
        #end=self.soc.send(self.start_command) # send 'start' command
        while True:
            t1_init = time.perf_counter()
            self.connect_fun(0)
            #for mean_cnt in range(10):

            #buf_index = 0
            #print('Tcp send')
            self.soc.send(self.start_command) # send 'start' command
            int_dat = []
            cmd_dat = []
            cmd_rec = []
            
            ############## receive data and cmd ###############
            #print('Tcp receive')
            cmd_rec = self.soc.recv(self.buffer_size)
            for i in cmd_rec[:]:  # transform bytes into int
                cmd_dat.append(int(i)) 

            if (int(cmd_dat[0]) == int('0x55', 16)) and (int(cmd_dat[1]) == int('0', 16)):
                int_dat = cmd_dat[2:]
                total_len = len(int_dat)
                #print('Tcp receive num:', total_len)
                while total_len < (16384 * 2 + 2048 * 2):
                    #if total_len > 36000:
                    #    break
                    tcp_dat = self.soc.recv(self.buffer_size) # receive data again
                    for i in tcp_dat[:]:  # transform bytes into int
                        int_dat.append(int(i))
                    total_len = len(int_dat)
                    #print('Tcp receive num:', total_len)

                
                #if total_len < (16384 * 2 + 2048 * 2):
                #    print('TCP data lost! Receive Num:', total_len)
                #    self.soc.close()
                #    self.connect_fun()
                #    continue

                self.array_buf[0][:] = np.array(int_dat[0:16384]) # 曝光前 Pod 数据
                self.array_buf[1][:] = np.array(int_dat[16384:32768])
                array_out_temp1 = np.array(int_dat[32768: (32768 + 2048)])
                array_out_temp2 = np.array(int_dat[(32768 + 2048) : (32768 + 4096)])  # 曝光后 Pod 数据

                # change the 8bit array_out_buf data into 64 bit
                array_shape_temp1  = array_out_temp1.reshape((32, 64), order = 'F')
                array_shape_temp2  = array_out_temp2.reshape((32, 64), order = 'F')
                self.array_out_shape[0]  = array_shape_temp1    # FPGA输出的 OUTR OUTL OUTU OUTD 数据
                # self.array_out_shape[1]  = array_shape_temp2    # Chip输出的 OUTR OUTL OUTU OUTD 数据
                self.array_pod_out  = array_shape_temp2         # Chip输出的 OUT 对应的Pod数据

                self.array_buf[2] = self.array_buf[0] - self.array_buf[1]

                self.img_buf[0] = self.tcp_data2mat(self.array_buf[2]) # reform bytes data into picture structure

                img = np.mat(self.img_buf[0].astype(np.uint8)) # transform img_data into uint8 matrix
                x, y = img.shape[0:2]
                img_test1 = cv2.resize(img, (int(y * 6), int(x * 6)))  # picture reshape (scaling)

                #print('Open-CV show picture')
                cv2.imshow('frame', img_test1)
                if cv2.waitKey(1) & 0xFF == ord('c'):
                    #self.buf_img = img
                    #self.buf_tcp_dat = before_array
                    return 0
            else:
                print('Frame lost! ERROR_code:' + str(cmd_dat[:2]))
                continue

            self.soc.close()
            frame_rate = 1/(time.perf_counter() - t1_init)
            print('Frame Rate:%5.3f' % frame_rate, '/s')
    
    def tcp_data2mat(self, int_dat):
        
        #temp = np.array(int_dat)
        #self.img_buf_index = (self.img_buf_index + 1) % self.img_buf_size

        t1 = int_dat.reshape(-1, 16)
        t2 = int_dat.reshape(-1, 16).T
        t3 = t2[0][:].reshape(64,4,2,2)

        pic = np.array([[0]*128]*128) # generate a 128x128 zero array
        for i in range(16):
            for j in range(64):
                for k in range(4):
                    pic[2*j  ][8*i+2*k  ] = t2[i][0+4*k+16*j]
                    pic[2*j  ][8*i+2*k+1] = t2[i][1+4*k+16*j]
                    pic[2*j+1][8*i+2*k+1] = t2[i][2+4*k+16*j]
                    pic[2*j+1][8*i+2*k  ] = t2[i][3+4*k+16*j]

        return pic
        

    def image_save_stop(self):
        # stop transfer
        self.connect_fun(0)
        end=self.soc.send(self.stop_command)
        image_dat = self.soc.recv(10)

        # create folder
        folder_name = "./Pic_data/" + time.strftime("%Y%m%d%H%M%S")
        dir_exist = os.path.isdir(folder_name)
        if not dir_exist:
            os.makedirs(folder_name)
        #time_info = time.strftime("%Y%m%d%H%M%S")

        # save data
        save = pd.DataFrame(self.img_buf[0])
        save.to_csv(folder_name + '/img_data.csv')
        save = pd.DataFrame(self.array_buf[0])
        save.to_csv(folder_name + '/before_exposure.csv')
        save = pd.DataFrame(self.array_buf[1])
        save.to_csv(folder_name + '/after_exposure.csv')
        save = pd.DataFrame(self.array_buf[2])
        save.to_csv(folder_name + '/sub_data.csv')

        #save = pd.DataFrame(self.array_out_buf[0])
        #save.to_csv(folder_name + '/out_chip_data.csv')
        save = pd.DataFrame(self.array_out_shape[0])
        save.to_csv(folder_name + '/out_fpga_data.csv')

        #save = pd.DataFrame(self.array_out_shape[1])
        #save.to_csv(folder_name + '/out_chip_data.csv')
        save = pd.DataFrame(self.array_pod_out)
        save.to_csv(folder_name + '/out_pod_data.csv')

        #save = pd.DataFrame(self.array_out_buf[1])
        #save.to_csv(folder_name + '/out_fpga_data.csv')

        if(image_dat == self.stop_reply):
            self.display_info.insert(0,'Stop and Save successfully!')

    def image_show(self):
        # Image show
        cap = cv2.VideoCapture(0)
        cap.open(0)
        while True:
            ret, frame = cap.read()
            if not ret:
                print("Can't receive frame (stream end?). Exiting ...")
                break
            gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
            cv2.imshow('frame', gray)
            if cv2.waitKey(1) == ord('q'):
                break
        cap.release()
        cv2.destroyAllWindows()

def main():
    # 初始化对象
    FL = ImageGUI()
    # 进行布局
    FL.gui_arrang()
    # 主程序执行
    tkinter.mainloop()
    pass


if __name__ == "__main__":
    main()


########### UDP client Transfer #########
#from socket import *
#HOST = '192.168.1.10'
#PORT = 8080
#BUFSIZ = 1024
#ADDRESS = (HOST, PORT)
#udpClientSocket = socket(AF_INET, SOCK_DGRAM)
#
#while True:
#    data  = bytes([int('0xFE', 16), 0,2,0,1])
#    if not data:
#        break
#
#    # 发送数据
#    udpClientSocket.sendto(data, ADDRESS)
#    # 接收数据
#    data, ADDR = udpClientSocket.recvfrom(BUFSIZ)
#    if not data:
#        break
#    print("服务器端响应：", data)
#
#udpClientSocket.close()

######## TCP Client Transfer #########
#client_sock = socket.socket()
#client_sock.connect(('192.168.1.10', 7))
## 发送个连接信息
#stop_command = bytes([int('0x55', 16), 3])  # udp must send bytes object
#client_sock.send(stop_command)
#while 1:
#    recv_dat = client_sock.recv(1024)
#    print(recv_dat)
#    # 有关输入的
#    aa = input("echo >>:")
#    if aa == 'exit':
#        break
#    while not aa:
#        aa = input("echo >>:")
#     # 重点就是上下两句
#    client_sock.send(aa.encode('utf-8'))
#client_sock.close()
