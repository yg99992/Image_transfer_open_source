# Real-time vedio transmission from Xilinx ZYNQ7000 platform to upper computer through TCP protocol

This project implement a real-time vedio transmission system from Xilinx ZYNQ7000 platform to upper computer using TCP protocol.

On the side of ZYNQ7000, FPGA obtains vedio data from a camera, and ARM core transfer the vedio data to upper computer using lwip TCP/IP protocol.

On the side of upper computer, a python PUI is designed to receive and show the vedio data using Opencv. 


**"Xilinx ZYNQ+TCP通信+Python上位机 实现实时视频传输系统"** Vivado 工程文件，Python 代码及操作步骤

详细讲解见微信公众号或知乎账号**IC设计者笔记**
`https://zhuanlan.zhihu.com/p/511452931`


本项目已经被发布到 [zenodo](https://zenodo.org/record/7830330#.ZDoNzegRWHs)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7830330.svg)](https://doi.org/10.5281/zenodo.7830330)

This project has been published at [zenodo](https://zenodo.org/record/7830330#.ZDoNzegRWHs) 
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.7830330.svg)](https://doi.org/10.5281/zenodo.7830330)

## 引用 Citation

如果你在自己的工作中用到了此工程，请加入如下引用：

If you have used this project in your own research, please include the following citation:

```
Chongyao Xu. (2023). Real-time vedio transmission from Xilinx ZYNQ7000 platform to upper computer using TCP protocol (Version v1). Zenodo. https://doi.org/10.5281/zenodo.7830330
```

BibTeX Export
```latex
@software{chongyao_xu_2023_7830330,
  author       = {Chongyao Xu},
  title        = {{Real-time vedio transmission from Xilinx ZYNQ7000 
                   platform to upper computer using TCP protocol}},
  month        = apr,
  year         = 2023,
  publisher    = {Zenodo},
  version      = {v1},
  doi          = {10.5281/zenodo.7830330},
  url          = {https://doi.org/10.5281/zenodo.7830330}
}
```
