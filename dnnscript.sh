#CI - supply frame level alignment of training data - DONE

for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20 MFC_E_D_A_Z_Flatstart20
do
	../tools/steps/step-align $PWD/$file/mono hmm84 \ $file/align-mono-hmm84
done


for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20 MFC_E_D_A_Z_Flatstart20
do
	../tools/steps/step-align $PWD/$file/mono hmm164 \ $file/align-mono-hmm164
done

#DNN Training CI
cd ~/MLSALT2/pracdnn/exp

for file in MFC_E_D_A_Z_Init20   MFC_E_D_A_Z_Flatstart20
do
pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -USEGPUID 0 ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-mono-hmm84/align/timit_train.mlf $pracgmmexp/mono/hmm84/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm84/$file
../tools/steps/step-dnntrain -USEGPUID 0 ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-mono-hmm164/align/timit_train.mlf $pracgmmexp/mono/hmm164/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm164/$file
done

for file in FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20
do
pracgmmexp=~/MLSALT2/pracgmm/exp/$file
../tools/steps/step-dnntrain -USEGPUID 0 ../convert/fbk25d/env/environment_D_A_Z \ $pracgmmexp/align-mono-hmm84/align/timit_train.mlf $pracgmmexp/mono/hmm84/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm84/$file
../tools/steps/step-dnntrain -USEGPUID 0 ../convert/mfc13d/env/environment_E_D_A_Z \ $pracgmmexp/align-mono-hmm164/align/timit_train.mlf $pracgmmexp/mono/hmm164/MMF \ $pracgmmexp/mono/hmms.mlist MHO/dnntrain/hmm164/$file
done

for hmm in hmm164 hmm84
	do
	for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20 MFC_E_D_A_Z_Flatstart20
	do	
	echo $hmm $file >> dnn.txt
	grep -A7 -P 'Epoch 12' MHO/dnntrain/$hmm/$file/dnn7.finetune/LOG >> dnn.txt
done
done
