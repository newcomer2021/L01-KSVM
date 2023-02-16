
1. libsvm训练代码的参数设置部分，给字符串参数添加 '-q' 
eg: 
        lib_opt =  sprintf('-t 0 -c %f -q',c);
        model = svmtrain( Y , X , lib_opt );
        ......
-----------------------------------------------------------------
2. 修改文件.\libsvm-3.24\matlab\svmpredict.c  
   (需.c编译器，如MinGW，把mingw.mlpkginstall拖进命令行窗口即可安装)
    A. 搜索 (classification) 找到输出代码
    B. 注释前后共3行
eg: 
	//else
	//	info("Accuracy = %g%% (%d/%d) (classification)\n",
	//		(double)correct/total*100,correct,total);
-----------------------------------------------------------------
3. 修改文件.\libsvm-3.24\matlab\make.m
    CFLAGS → COMPFLAGS
eg: 
    else
        mex COMPFLAGS="\$CFLAGS -std=c99" -largeArrayDims libsvmread.c
        mex COMPFLAGS="\$CFLAGS -std=c99" -largeArrayDims libsvmwrite.c
    ......
-----------------------------------------------------------------
4. 重新编译
    A. 当前文件夹设为 .\libsvm-3.24\matlab 
    B. 命令行窗口运行指令 make
    C. 等待生成新的 .mexw64 文件
-----------------------------------------------------------------
5. 文件替换
    将文件 .\libsvm-3.24\matlab\svmpredict.mexw64 
    复制到 .\libsvm-3.24\windows\svmpredict.mexw64 
    替换原有文件
-----------------------------------------------------------------
6. 禁止输出

