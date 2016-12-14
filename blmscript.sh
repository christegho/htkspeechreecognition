#!/bin/zsh


# Create a phone-level back-off bigram language model
# -t Set the threshold count for including a bigram in a backed-off bigram language model.
../tools/htkbin/HLStats -A -D -T 1 -b back_off_bigram -t 3 -u 1.0 -o phone-list.txt ../convert/mfc13d/lib/mlabs/train.mlf 

# Build a bigram network
../tools/htkbin/HBuild -A -D -T 1  -n back_off_bigram phone-list.txt bigram_network

#Decode triphone GMM 
#In progress

for file in MFC_E_D_A_Z_Init20 FBK_D_A_Z_Init20 MFC_E_D_A_Z_Flatstart20 FBK_D_A_Z_Flatstart20
	do
	for testOpt in CORETEST SUBTRAIN
	do
	for tb in 5000 
	do
	for i in 8 16
	do
	for grammarscale in  $(seq 0 1 13)
        do
	for insword in 0 -4 -8
	do
	hmm=hmm${i}4
	filename=decode-xwtri-bigram-$hmm
	echo $file $filename -TB $tb -GRAMMARSCALE ${grammarscale} -${testOpt} -INSWORD $insword
	../tools/steps/step-decode \
	-DECODEHTE /home/ct506/MLSALT2/pracgmm/pracblm/HTE.bigram \
	-${testOpt} -INSWORD $insword \
	-GRAMMARSCALE ${grammarscale} \
	/home/ct506/MLSALT2/pracgmm/exp/$file/xwtri/RO100/TB$tb $hmm $file/xwtri/RO100/TB$tb/GRAMMARSCALE${grammarscale}INS${insword}${testOpt}/$filename
	echo $file $filename -TB $tb -GRAMMARSCALE ${grammarscale} -${testOpt} -INSWORD $insword >>bigramtri${tb}.txt
	grep -A2 -P 'SENT' $file/xwtri/RO100/TB$tb/GRAMMARSCALE${grammarscale}INS${insword}${testOpt}/$filename/test/LOG >>bigramtri${tb}.txt
	
done
done
done
done
done
done

#MONO
#In Progress
for file in MFC_E_D_A_Z_Init20 FBK_D_A_Z_Init20 MFC_E_D_A_Z_Flatstart20 FBK_D_A_Z_Flatstart20
	do
	for testOpt in CORETEST SUBTRAIN
	do
	for i in 8 16
	do
	for grammarscale in  $(seq 0 1 13)
        do
	for insword in 0 -4 -8
	do
	hmm=hmm${i}4
	filename=decode-mono-bigram-$hmm
	echo $file $filename -TB $tb -GRAMMARSCALE ${grammarscale} -${testOpt} -INSWORD $insword
	../tools/steps/step-decode \
	-DECODEHTE /home/ct506/MLSALT2/pracgmm/pracblm/HTE.bigram \
	-${testOpt} -INSWORD $insword \
	-GRAMMARSCALE ${grammarscale} \
	/home/ct506/MLSALT2/pracgmm/exp/$file/mono $hmm $file/mono/GRAMMARSCALE${grammarscale}INS${insword}${testOpt}/$filename
	echo $file $filename -TB $tb -GRAMMARSCALE ${grammarscale} -${testOpt} -INSWORD $insword >>bigrammono.txt
	grep -A2 -P 'SENT' $file/mono/GRAMMARSCALE${grammarscale}INS${insword}${testOpt}/$filename/test/LOG >>bigrammono.txt
	
done
done
done
done

#Decode triphone DNNs
#TODO need to do coretest as well
for i in 7
do
H=$i
dnnft=$(expr $i + 2)
for N in  650
do
for hmm in  hmm84
	do
	for file in MFC_E_D_A_Z_Init20  FBK_D_A_Z_Init20 
	do	

	echo $hmm $file -CS 4 -H $H -N 500 >> dnntesttribigram.txt
	echo $hmm $file -H $H -N $N 
	../tools/steps/step-decode -DECODEHTE $PWD/HTE.bigram -SUBTRAIN -GRAMMARSCALE 9 ../../pracdnn/exp/MHO/dnntraintri/$hmm/${file}_${H}H_CS4_N${N} dnn${dnnft}.finetune MHO/decode-tri-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS4_N${N}
	grep -A2 -P 'SENT' MHO/decode-tri-dnn${dnnft}.finetune/$hmm/${file}_${H}H_CS4_N${N}/test/LOG >> dnntesttribigram.txt

done
done
done
done
