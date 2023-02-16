%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%■■■数据导入，参见如下数据位置和导入格式■■■
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1 % ■UCI■
%%%%%%%%%%%%%%%%%%%%%%%%%    
%■■■UCI datasets■■■
%%%%%%%%%%%%%%%%%%%%%%%%%                   Size	Fea  Rate+/-  Density(~0)
% % % 
% load './Data/UCI/Abalone.mat' X Y         %4174	 8    1/99    0.9598
% load './Data/UCI/Adult.mat' X Y           %17887	13   25/75    0.9874
% load './Data/UCI/Australian.mat' X Y      %690 	14   44/56    0.7996
% load './Data/UCI/Balances.mat' X Y        %625     4    8/92    0.9216
% load './Data/UCI/Bank.mat' X Y            %690    15   45/55    0.7978
% load './Data/UCI/Breast.mat' X Y          %699   	 9   34/66    1.0000
% load './Data/UCI/BUPA.mat' X Y            %345   	 6   42/58    0.9957
% load './Data/UCI/Cleveland.mat' X Y       %173    13    8/92    0.7052
% load './Data/UCI/CMC.mat' X Y             %1473    9   77/23    0.8454
% load './Data/UCI/Creadit.mat' X Y         %690    15   44/56    0.9120
% load './Data/UCI/Diabetics.mat' X Y       %768     8   35/65    0.9758
% load './Data/UCI/Echo.mat' X Y            %131    10   33/67    0.7985
load './Data/UCI/Ecoli.mat' X Y           %336     7   10/90    0.9983
% load './Data/UCI/German.mat' X Y          %1000   20   70/30    1.0000
% % % 
% load './Data/UCI/Haberman.mat' X Y        %306     3   76/26    0.8519
% load './Data/UCI/Heartc.mat' X Y          %303    14   46/54    0.7289
% load './Data/UCI/Heartstatlog.mat' X Y	%270    13   56/44    0.7510
% load './Data/UCI/Hepatitis.mat' X Y       %155    19   21/79    0.9997
% load './Data/UCI/Hourse.mat' X Y          %300    26   60/40    0.9169
% load './Data/UCI/Housevotes.mat' X Y      %435    16   61/39    1.0000
% load './Data/UCI/Hypothyroid.mat' X Y     %3163   25    5/95    0.9806
% load './Data/UCI/Ionosphere.mat' X Y      %351    34   36/64    0.8809
% load './Data/UCI/Led7digit.mat' X Y       %443     7    8/92    0.6556
% load './Data/UCI/Monks3.mat' X Y          %432     6   50/50    1.0000
% load './Data/UCI/New-thyroid.mat' X Y     %215     4   16/84    1.0000
% % % 
% load './Data/UCI/Page-blocks.mat' X Y     %5472   10   10/90    1.0000
% load './Data/UCI/Parkinsons.mat' X Y      %195    22   75/25    1.0000
% load './Data/UCI/PimaIndian.mat' X Y      %768     8   35/65    0.8758
% load './Data/UCI/Segment.mat' X Y         %2308   19   14/86    0.8842
% load './Data/UCI/Shuttle.mat' X Y         %1829    9    7/93    0.7757
% load './Data/UCI/Sonar.mat' X Y           %208    60   47/53    0.9993
% load './Data/UCI/Spanbas.mat' X Y         %4601   57   39/61    0.2259
% load './Data/UCI/Spect.mat' X Y           %267    44   79/21    1.0000
% load './Data/UCI/TIC.mat' X Y             %5822   85    6/94    0.4442
% load './Data/UCI/TicTacToe.mat' X Y       %958    27   65/35    0.3333
% load './Data/UCI/Titanic.mat' X Y         %2201    3   32/68    0.7783
% load './Data/UCI/ToyDataType1.mat' X Y    %210     2   48/52    1.0000
% load './Data/UCI/ToyDataType2.mat' X Y    %210     2   50/50    1.0000
% load './Data/UCI/Transfusion.mat' X Y     %784     4   24/76    0.9983
% load './Data/UCI/TwoNorm.mat' X Y         %7400   20   50/50    1.0000
% % % 
% load './Data/UCI/Vehicle.mat' X Y         %940    18   24/76    0.9930
% load './Data/UCI/Vowel.mat' X Y           %988    13    9/91    0.9123
% load './Data/UCI/Waveform.mat' X Y        %5000   21   33/67    0.9984
% load './Data/UCI/WDBC.mat' X Y            %569    30   37/63    0.9954
% load './Data/UCI/Wine.mat' X Y            %178    13   33/67    1.0000
% load './Data/UCI/Wisconsin.mat' X Y       %683     9   35/65    1.0000
% load './Data/UCI/WPBC.mat' X Y            %198    34   24/76    0.9871
% load './Data/UCI/Yeast.mat' X Y           %1481    8   11/89    0.8759
end

for i=1 % ■UCI Feature 15%Noise 5%Gauss■
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%■■■UCI datasets 15% feature noise (5% Gaussian)■■■
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load './Data/Feature Noise/UCI/Adult_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Adult_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Australian_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Australian_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Breast_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Breast_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/BUPA_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/BUPA_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/CMC_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/CMC_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Diabetics_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Diabetics_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Echo_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Echo_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/German_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/German_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Heartc_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Heartc_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Heartstatlog_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Heartstatlog_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Hepatitis_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Hepatitis_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Housevotes_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Housevotes_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Ionosphere_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Ionosphere_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Monks3_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Monks3_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/PimaIndian_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/PimaIndian_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Sonar_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Sonar_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Spect_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Spect_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/TicTacToe_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/TicTacToe_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/WDBC_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/WDBC_015Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/WPBC_015Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/WPBC_015Fea_No2.mat' X Y
end

for i=1 % ■UCI Feature 30%Noise 5%Gauss■
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%■■■UCI datasets 30% feature noise (5% Gaussian)■■■
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load './Data/Feature Noise/UCI/Adult_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Adult_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Australian_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Australian_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Breast_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Breast_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/BUPA_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/BUPA_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/CMC_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/CMC_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Diabetics_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Diabetics_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Echo_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Echo_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/German_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/German_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Heartc_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Heartc_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Heartstatlog_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Heartstatlog_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Hepatitis_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Hepatitis_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Housevotes_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Housevotes_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Ionosphere_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Ionosphere_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Monks3_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Monks3_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/PimaIndian_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/PimaIndian_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Sonar_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Sonar_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/Spect_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/Spect_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/TicTacToe_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/TicTacToe_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/WDBC_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/WDBC_030Fea_No2.mat' X Y
% 
% load './Data/Feature Noise/UCI/WPBC_030Fea_No1.mat' X Y
% load './Data/Feature Noise/UCI/WPBC_030Fea_No2.mat' X Y
end

for i=1 % ■UCI Outliers 3IQR 1perct■
% load './Data/Outliers/UCI/Adult_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/Australian_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/Breast_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/BUPA_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/CMC_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/Creadit_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/Diabetics_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/Echo_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/German_001Outliers_3IQR.mat' X Y
% 
% load './Data/Outliers/UCI/Haberman_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/Heartc_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/Heartstatlog_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/Hepatitis_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/Hourse_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/Housevotes_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/Hypothyroid_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/Ionosphere_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/Monks3_001Outliers_3IQR.mat' X Y
% 
% load './Data/Outliers/UCI/PimaIndian_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/Sonar_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/Spanbas_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/Spect_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/TIC_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/TicTacToe_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/Titanic_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/Two-Norm_001Outliers_3IQR.mat' X Y
% 
% load './Data/Outliers/UCI/Waveform_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/WDBC_001Outliers_3IQR.mat' X Y
% load './Data/Outliers/UCI/WPBC_001Outliers_3IQR.mat' X Y
end

for i=1 % ■UCI Label 15%Noise■
% load './Data/Label Noise/UCI/Abalone_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Adult_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Australian_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Balances_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Breast_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/BUPA_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Cleveland_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/CMC_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Creadit_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Diabetics_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Echo_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Ecoli_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/German_015Label_No1.mat' X Y
% 
% load './Data/Label Noise/UCI/Haberman_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Heartc_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Heartstatlog_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Hepatitis_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Hourse_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Housevotes_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Hypothyroid_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Ionosphere_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Led7digit_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Monks3_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/New-thyroid_015Label_No1.mat' X Y
% 
% load './Data/Label Noise/UCI/Page-blocks_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Parkinsons_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/PimaIndian_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Segment_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Shuttle_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Sonar_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Spanbas_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Spect_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/TIC_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/TicTacToe_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Titanic_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Transfusion_015Label_No1.mat' X Y
% 
% load './Data/Label Noise/UCI/Vehicle_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Vowel_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/WDBC_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Wine_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Wisconsin_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/WPBC_015Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Yeast_015Label_No1.mat' X Y
% % ------------------------------------------------------------
% load './Data/Label Noise/UCI/Abalone_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Adult_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Australian_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Balances_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Breast_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/BUPA_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Cleveland_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/CMC_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Creadit_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Diabetics_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Echo_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Ecoli_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/German_015Label_No2.mat' X Y
% 
% load './Data/Label Noise/UCI/Haberman_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Heartc_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Heartstatlog_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Hepatitis_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Hourse_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Housevotes_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Hypothyroid_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Ionosphere_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Led7digit_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Monks3_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/New-thyroid_015Label_No2.mat' X Y
% 
% load './Data/Label Noise/UCI/Page-blocks_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Parkinsons_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/PimaIndian_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Segment_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Shuttle_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Sonar_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Spanbas_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Spect_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/TIC_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/TicTacToe_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Titanic_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Transfusion_015Label_No2.mat' X Y
% 
% load './Data/Label Noise/UCI/Vehicle_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Vowel_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/WDBC_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Wine_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Wisconsin_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/WPBC_015Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Yeast_015Label_No2.mat' X Y
end

for i=1 % ■UCI Label 30%Noise■
% load './Data/Label Noise/UCI/Abalone_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Adult_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Australian_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Balances_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Breast_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/BUPA_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Cleveland_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/CMC_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Creadit_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Diabetics_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Echo_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Ecoli_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/German_030Label_No1.mat' X Y
% 
% load './Data/Label Noise/UCI/Haberman_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Heartc_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Heartstatlog_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Hepatitis_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Hourse_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Housevotes_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Hypothyroid_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Ionosphere_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Led7digit_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Monks3_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/New-thyroid_030Label_No1.mat' X Y
% 
% load './Data/Label Noise/UCI/Page-blocks_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Parkinsons_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/PimaIndian_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Segment_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Shuttle_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Sonar_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Spanbas_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Spect_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/TIC_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/TicTacToe_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Titanic_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Transfusion_030Label_No1.mat' X Y
% 
% load './Data/Label Noise/UCI/Vehicle_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Vowel_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/WDBC_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Wine_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Wisconsin_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/WPBC_030Label_No1.mat' X Y
% load './Data/Label Noise/UCI/Yeast_030Label_No1.mat' X Y
% % ---------------------------------------------------------
% load './Data/Label Noise/UCI/Abalone_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Adult_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Australian_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Balances_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Breast_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/BUPA_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Cleveland_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/CMC_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Creadit_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Diabetics_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Echo_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Ecoli_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/German_030Label_No2.mat' X Y
% 
% load './Data/Label Noise/UCI/Haberman_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Heartc_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Heartstatlog_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Hepatitis_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Hourse_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Housevotes_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Hypothyroid_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Ionosphere_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Led7digit_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Monks3_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/New-thyroid_030Label_No2.mat' X Y
% 
% load './Data/Label Noise/UCI/Page-blocks_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Parkinsons_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/PimaIndian_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Segment_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Shuttle_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Sonar_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Spanbas_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Spect_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/TIC_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/TicTacToe_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Titanic_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Transfusion_030Label_No2.mat' X Y
% 
% load './Data/Label Noise/UCI/Vehicle_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Vowel_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/WDBC_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Wine_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Wisconsin_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/WPBC_030Label_No2.mat' X Y
% load './Data/Label Noise/UCI/Yeast_030Label_No2.mat' X Y
end

for i=1 % ■Artificial■
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%■■■Artificial datasets■■■
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load ./Data/Artificial/Binary1.mat X Y
% load Binary1_015Label.mat X Y
% load Binary1_030Label.mat X Y

% load ./Data/Artificial/Binary1LabelNoise1.mat
% load ./Data/Artificial/Binary1LabelNoise2.mat
% load ./Data/Artificial/Binary1LabelNoise3.mat
% load ./Data/Artificial/Binary2.mat X Y
% load ./Data/Artificial/Binary2Outliers1.mat
% load ./Data/Artificial/Binary2Outliers2.mat
% load ./Data/Artificial/Binary2Outliers3.mat

% load ./Data/Artificial/Binary1.mat X Y
% load ./Data/Artificial/15_Binary1_Label_1.mat X Y
% load ./Data/Artificial/15_Binary1_Label_2.mat X Y
% load ./Data/Artificial/30_Binary1_Label_1.mat X Y
% load ./Data/Artificial/30_Binary1_Label_2.mat X Y

% load ./Data/Artificial/testxxx.mat

% load ./Data/Artificial/Binary2.mat X Y
% load ./Data/Artificial/Binary3.mat X Y
% load ./Data/Artificial/Binary4.mat X Y
% load ./Data/Artificial/Binary5.mat X Y

% load ./Data/Artificial/CrossPlanesTest1.mat X Y
% load ./Data/Artificial/CrossPlanesTest2.mat X Y
% load ./Data/Artificial/CrossPlanesTest3.mat X Y
% load ./Data/Artificial/CrossPlanesTest4.mat X Y
% load ./Data/Artificial/CrossPlanesTest5.mat X Y

% load ./Data/Artificial/CrossplaneUBal.mat X Y
% load ./Data/Artificial/Exampledata2.mat X Y
% load ./Data/Artificial/LocalAnays.mat X Y

% load ./Data/Artificial/synth.mat X Y
% load ./Data/Artificial/CrossplaneXY.mat X Y
% load ./Data/Artificial/checkerboard.mat A B
% load ./Data/Artificial/Halfcircle.mat X Y
end

for i=1 % ■NDC■

% load './Data/NDC/n10k.mat' X Y              	%10000      32
% load './Data/NDC/n15k.mat' X Y              	%15000      32
% load './Data/NDC/n20k.mat' X Y               	%20000      32
% load './Data/NDC/n30k.mat' X Y             	%30000      32
% load './Data/NDC/n50k.mat' X Y                %50000      32
% load './Data/NDC/n100k.mat' X Y               %100000     32
% load './Data/NDC/n1000k.mat' X Y              %1000000    32
% 
% load './Data/NDC/n60.mat' X Y               	%60         32
% load './Data/NDC/n70.mat' X Y               	%70         32
% load './Data/NDC/n80.mat' X Y               	%80         32
% load './Data/NDC/n90.mat' X Y               	%90         32
% load './Data/NDC/n100.mat' X Y              	%100        32
% load './Data/NDC/n200.mat' X Y              	%200        32
% load './Data/NDC/n300.mat' X Y              	%300        32
% load './Data/NDC/n400.mat' X Y               	%400        32
% load './Data/NDC/n500.mat' X Y               	%500        32
% load './Data/NDC/n600.mat' X Y             	%600        32
% load './Data/NDC/n700.mat' X Y               	%700        32
% load './Data/NDC/n800.mat' X Y              	%800        32
% load './Data/NDC/n900.mat' X Y              	%900        32
% load './Data/NDC/n1000.mat' X Y              	%1000       32
% load './Data/NDC/n1500.mat' X Y              	%1500       32
% load './Data/NDC/n2000.mat' X Y              	%2000       32
% load './Data/NDC/n3000.mat' X Y              	%3000       32
% load './Data/NDC/n4000.mat' X Y              	%4000       32
% load './Data/NDC/n5000.mat' X Y              	%5000       32
% load './Data/NDC/n6000.mat' X Y             	%6000       32
% load './Data/NDC/n7000.mat' X Y              	%7000       32
% load './Data/NDC/n8000.mat' X Y              	%8000       32
% load './Data/NDC/n9000.mat' X Y              	%9000       32
% 
% load './Data/NDC/NDCbig.mat' X Y             	%1000000   	32
% load './Data/NDC/NDCnormal.mat' X Y         	%100000    	32
% load './Data/NDC/NDCnormal11.mat' X Y        	%100000   	384
% load './Data/NDC/NDCnormal22.mat' X Y        	%9999       1536

end




% load 4incp.mat X Y
% load 4incp_eg.mat X Y
% load 4incp_egg.mat X Y
% load 4incp_eggg.mat X Y

%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%■■■数据格式转化■■■
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% load './Data/Image/Coil20_32.mat' o1 o2 o7
% Data.Type = 1;Data.A = o1;Data.B =[o2;o7];

%■■■■■■■■■■■■■■■■■■
X = mapminmax(X',0,1)';     %归一化
% X = zscore(X);              %0均值标准化    outliers
% X = dct2(X);                %余弦变换
%■■■■■■■■■■■■■■■■■■


Data.Type = 2;Data.X = X;Data.Y = Y;
clear X Y i;
Data = DataTypeTrans(Data,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%■■■参数配置和初始化■■■
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SVMFun = @RSVC;
FunPara.type = 'RSVC';
% FunPara.c1=0.1;
% FunPara.c2=0.1;
% FunPara.pnum = 2;
%Setting 'lin' means 线性；‘rbf’非线性，非线性需要设置参数FunPara.kerfPara.pars
%■■■■■■■■■■■■■■■■■■
FunPara.kerfPara.type = 'lin';    %
% FunPara.kerfPara.type = 'rbf';    %
% FunPara.kerfPara.type = 'cro';    % CRO Hash using DCT
%■■■■■■■■■■■■■■■■■■
FunPara.kerfPara.pars1 = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%■■■十折交叉验证■■■
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FunPara = KfoldParaSearch_C(Data,SVMFun,FunPara);
FunPara = KfoldGmeanParaSearch(Data,SVMFun,FunPara);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%■■■非十折交叉验证， 即有训练集也有预测集■■■
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FunPara = NoKfoldParaSearch_C(Data,SVMFun,FunPara);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%■■■画图（如果需要） 仅仅可画2D的数据图■■■
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot2DContour(Data,SVMFun,FunPara);
% Plot2DSepLine(Data,SVMFun,FunPara);
% Plot2DProjection(Data,SVMFun,FunPara);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%■■■绘制ROC曲线（如果需要）■■■
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %绘制ROC曲线
% k = 10;
% indices = crossvalind('Kfold',Data.X(:,1),k); %矩阵k折分类后的索引值
% test = (indices == 1); train = ~test;
% DataTrain.Type = 2;
% DataTrain.X = Data.X(train,:);
% DataTrain.Y = Data.Y(train,:);
% 
% [Predict_Y,Predict_YP]=SVMFun(Data.X(test,:),DataTrain,FunPara);
% Accu = sum(Data.Y(test,:) == Predict_Y)/length(Predict_Y);
% [Pr1,Pr0]=ProbTWSVCoutput(Predict_YP,Data.Y(test,:));
% figure;
% ROCdata=myroc(Pr1,Data.Y(test,:));


% load train
% sound(y,Fs)