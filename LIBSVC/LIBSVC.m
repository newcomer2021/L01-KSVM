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

% model.nr_class ---- ���ݼ����ж������
% model.totalSV ---- ֧���������ܸ�����
% model.rho -------- ƫ������෴��(��-b)��
% model.Label ------ ���ݼ������ľ���Ǻţ���Ӧ��nr_class;
% model.sv_indices ----- ֧��������ѵ�����е����������ڼ���ѵ������Ϊ֧����������һ����СΪtotalSV��������;
% model.ProbA&B -- ����������ʹ��-b����ʱ�����õ������ڸ��ʹ���;
% model.nSV -------- ÿ��������֧����������Ŀ��(ע�⣺����nSV�������ǵ�˳����Label��Ӧ)
% model.sv_coef ---- ֧��������Ӧ�Ħ�iyi����һ����СΪtotalSV��������;
% model.SVs -------- ����֧����������ϡ���ʽ�洢����ҪתΪ��ͨ�����ʹ�ú���full;

% % SVM use hyperplanes to perform classification. While performing 
% % classifications using SVM there are 2 types of SVM
% % ��C-SVM
% % ��Nu-SVM
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
% % SVMʹ�ó�ƽ��ִ�з��ࡣʹ��SVMִ�з���ʱ�����������͵�SVM
% % C SVM
% % Nu SVM
% % C��nu�����򻯲����������ڶԷ���ʱִ�еĴ������ʵʩ�ͷ���
% % �����������������׼ȷ�ԡ�
% % C��Χ��0������󣬿����е��ѹ��ƺ�ʹ�á��Դ˵��޸�����0-1֮�����е�nu�����룬
% % ���ұ�ʾ��Ϊ֧�����������ӵ���Ŀ�����޺����ޣ���λ�ڳ�ƽ��Ĵ���ࡣ
% % ���߶��������Ƶķ�����������nu-SVM�����Ż�



% SVMPara =  sprintf('-t 0 -c %f -q',C);
% libmodel = svmtrain(y,X,SVMPara);
% 
% libSVs_idx = libmodel.sv_indices; % libSVs Index
% nlibSVs = length(libSVs_idx); % # of libSVs
% x_SVs = full(libmodel.SVs); % 
% y_SVs = y(libSVs_idx);
% 
% alpha_SVs = libmodel.sv_coef; % actually alpha_i*y_i
% w = sum(diag(alpha_SVs)*x_SVs)'; %����w = sum(alpha_i*y_i*x_i)
% 
% SVs_on_idx = (abs(alpha_SVs)<C); % SV_index on the support hyperplane
% y_SVs_on = y_SVs(SVs_on_idx,:);
% x_SVs_on = x_SVs(SVs_on_idx,:);
% %�����Ͽ�ѡȡ������������߽��ϵ�֧������ͨ�����������ʽ(6.17)���b
% b_temp = zeros(1,sum(SVs_on_idx));%���е�b
% for idx=1:sum(SVs_on_idx)
%     b_temp(idx) = 1/y_SVs_on(idx)-x_SVs_on(idx,:)*w;
% end
% b = mean(b_temp);%��³����������ʹ������֧����������ƽ��ֵ
% 
% %���ֶ��������ƫ����b��svmtrain������ƫ����b�Ա�
% b_model = -libmodel.rho;%model�е�rhoΪ-b


