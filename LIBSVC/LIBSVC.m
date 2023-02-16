function [Predict_Y,model] = LIBSVC(TestX,DataTrain,Para)
   
	c = Para.p1;     kpar = Para.kpar;
    %n = Para.p2;    % nu-SVC
    X = DataTrain.X;    Y = DataTrain.Y;    clear DataTrain
    [m,~] = size(TestX);
    
   if strcmp(kpar.type,'lin') 
        lib_opt =  sprintf('-t 0 -c %f -q',c);
        %lib_opt =  sprintf('-s 1 -t 0 -c %f -n %f',c,n);    %-s 1 -- nu-SVC
    elseif strcmp(kpar.type,'rbf')
        lib_opt =  sprintf('-t 2 -c %f -g %f -q',c,kpar.par1);
        %lib_opt =  sprintf('-s 1 -t 2 -c %f -n %f -g %f',c,n,Para.kpar.pars);
    end

    % SVM training
	t = tic;
    model = svmtrain( Y , X , lib_opt );
    trn_time = toc(t);
    
    % SVM predicting
     [Predict_Y,~,decision_values]= svmpredict(ones(m,1),TestX,model); 

    model.tr_time = trn_time;
    model.n_SV = model.totalSV;
    model.ind_SV = model.sv_indices;
    if Para.drw == 1
        drw.ds = decision_values;
        drw.ss1 = drw.ds - 1;
        drw.ss2 = drw.ds + 1;
        model.drw = drw;
        model.twin = 0;
    end
end



% ------------------------------------------------------------------------------------------
% % Usage: model = svmtrain(training_label_vector, training_instance_matrix, 'libsvm_options');
% % libsvm_options:
% % -s svm_type : set type of SVM (default 0)
% % 	0 -- C-SVC
% % 	1 -- nu-SVC
% % 	2 -- one-class SVM
% % 	3 -- epsilon-SVR
% % 	4 -- nu-SVR
% % -t kernel_type : set type of kernel function (default 2)
% % 	0 -- linear: u'*v
% % 	1 -- polynomial: (gamma*u'*v + coef0)^degree
% % 	2 -- radial basis function: exp(-gamma*|u-v|^2)
% % 	3 -- sigmoid: tanh(gamma*u'*v + coef0)
% % 	4 -- precomputed kernel (kernel values in training_instance_matrix)
% % -d degree : set degree in kernel function (default 3)
% % -g gamma : set gamma in kernel function (default 1/num_features)
% % -r coef0 : set coef0 in kernel function (default 0)
% % -c cost : set the parameter C of C-SVC, epsilon-SVR, and nu-SVR (default 1)
% % -n nu : set the parameter nu of nu-SVC, one-class SVM, and nu-SVR (default 0.5)
% % -p epsilon : set the epsilon in loss function of epsilon-SVR (default 0.1)
% % -m cachesize : set cache memory size in MB (default 100)
% % -e epsilon : set tolerance of termination criterion (default 0.001)
% % -h shrinking : whether to use the shrinking heuristics, 0 or 1 (default 1)
% % -b probability_estimates : whether to train a SVC or SVR model for probability estimates, 0 or 1 (default 0)
% % -wi weight : set the parameter C of class i to weight*C, for C-SVC (default 1)
% % -v n : n-fold cross validation mode
% % -q : quiet mode (no outputs)

% model.nr_class ---- 数据集中有多少类别；
% model.totalSV ---- 支持向量的总个数；
% model.rho -------- 偏移项的相反数(即-b)；
% model.Label ------ 数据集中类别的具体记号，对应于nr_class;
% model.sv_indices ----- 支持向量在训练集中的索引，即第几个训练样本为支持向量，是一个大小为totalSV的列向量;
% model.ProbA&B -- 这两个参数使用-b参数时才能用到，用于概率估计;
% model.nSV -------- 每类样本的支持向量的数目；(注意：这里nSV所代表标记的顺序与Label对应)
% model.sv_coef ---- 支持向量对应的αiyi，是一个大小为totalSV的列向量;
% model.SVs -------- 所有支持向量，以稀疏格式存储，若要转为普通矩阵可使用函数full;

% % SVM use hyperplanes to perform classification. While performing 
% % classifications using SVM there are 2 types of SVM
% % ●C-SVM
% % ●Nu-SVM
% % C and nu are regularisation parameters which help implement a penalty on 
% % the misclassifications that are performed while separating the classes. 
% % Thus helps in improving the accuracy of the output.
% % C ranges from 0 to infinity and can be a bit hard to estimate and use. 
% % A modification to this was the introduction of nu which operates between 
% % 0-1 and represents the lower and upper bound on the number of examples 
% % that are support vectors and that lie on the wrong side of the hyperplane.
% % Both have a comparative similar classification power, but the nu- SVM 
% % has been harder to optimise.
% % 
% % SVM使用超平面执行分类。使用SVM执行分类时，有两种类型的SVM
% % C SVM
% % Nu SVM
% % C和nu是正则化参数，有助于对分类时执行的错误分类实施惩罚。
% % 因此有助于提高输出的准确性。
% % C范围从0到无穷大，可能有点难估计和使用。对此的修改是在0-1之间运行的nu的引入，
% % 并且表示作为支持向量的例子的数目的下限和上限，其位于超平面的错误侧。
% % 两者都具有相似的分类能力，但nu-SVM难以优化



% SVMPara =  sprintf('-t 0 -c %f -q',C);
% libmodel = svmtrain(y,X,SVMPara);
% 
% libSVs_idx = libmodel.sv_indices; % libSVs Index
% nlibSVs = length(libSVs_idx); % # of libSVs
% x_SVs = full(libmodel.SVs); % 
% y_SVs = y(libSVs_idx);
% 
% alpha_SVs = libmodel.sv_coef; % actually alpha_i*y_i
% w = sum(diag(alpha_SVs)*x_SVs)'; %■■w = sum(alpha_i*y_i*x_i)
% 
% SVs_on_idx = (abs(alpha_SVs)<C); % SV_index on the support hyperplane
% y_SVs_on = y_SVs(SVs_on_idx,:);
% x_SVs_on = x_SVs(SVs_on_idx,:);
% %理论上可选取任意在最大间隔边界上的支持向量通过求解西瓜书式(6.17)获得b
% b_temp = zeros(1,sum(SVs_on_idx));%所有的b
% for idx=1:sum(SVs_on_idx)
%     b_temp(idx) = 1/y_SVs_on(idx)-x_SVs_on(idx,:)*w;
% end
% b = mean(b_temp);%更鲁棒的做法是使用所有支持向量求解的平均值
% 
% %将手动计算出的偏移项b与svmtrain给出的偏移项b对比
% b_model = -libmodel.rho;%model中的rho为-b


