
#Biphone generate with different TBVAL
../tools-bip/step-xbil -NUMMIXES 20 -ROVAL 100 -TBVAL 4000 \ $PWD/MFC_E_D_A_Z_Flatstart20/mono hmm14 MFC_E_D_A_Z_Flatstart20/xwbir/RO100/TB4000

../tools-bip/step-xbil -NUMMIXES 20 -ROVAL 100 -TBVAL 4000 \ $PWD/MFC_E_D_A_Z_Init20/mono hmm14 MFC_E_D_A_Z_Init20/xwbir/RO100/TB4000

../tools-bip/step-xbil -NUMMIXES 20 -ROVAL 100 -TBVAL 4000 \ $PWD/FBK_D_A_Z_Flatstart20/mono hmm14 FBK_D_A_Z_Flatstart20/xwbir/RO100/TB4000

../tools-bip/step-xbil -NUMMIXES 20 -ROVAL 100 -TBVAL 4000 \ $PWD/FBK_D_A_Z_Init20/mono hmm14 FBK_D_A_Z_Init20/xwbir/RO100/TB4000

../tools-bip/step-xbir -NUMMIXES 20 -ROVAL 100 -TBVAL 4000 \ $PWD/MFC_E_D_A_Z_Flatstart20/mono hmm14 MFC_E_D_A_Z_Flatstart20/xwbir/RO100/TB4000

../tools-bip/step-xbir -NUMMIXES 20 -ROVAL 100 -TBVAL 4000 \ $PWD/MFC_E_D_A_Z_Init20/mono hmm14 MFC_E_D_A_Z_Init20/xwbir/RO100/TB4000

../tools-bip/step-xbir -NUMMIXES 20 -ROVAL 100 -TBVAL 4000 \ $PWD/FBK_D_A_Z_Flatstart20/mono hmm14 FBK_D_A_Z_Flatstart20/xwbir/RO100/TB4000

../tools-bip/step-xbir -NUMMIXES 20 -ROVAL 100 -TBVAL 4000 \ $PWD/FBK_D_A_Z_Init20/mono hmm14 FBK_D_A_Z_Init20/xwbir/RO100/TB4000

../tools-bip/step-xbil -NUMMIXES 20 -ROVAL 100 -TBVAL 2000 \ $PWD/MFC_E_D_A_Z_Flatstart20/mono hmm14 MFC_E_D_A_Z_Flatstart20/xwbir/RO100/TB2000

../tools-bip/step-xbil -NUMMIXES 20 -ROVAL 100 -TBVAL 2000 \ $PWD/MFC_E_D_A_Z_Init20/mono hmm14 MFC_E_D_A_Z_Init20/xwbir/RO100/TB2000

../tools-bip/step-xbil -NUMMIXES 20 -ROVAL 100 -TBVAL 2000 \ $PWD/FBK_D_A_Z_Flatstart20/mono hmm14 FBK_D_A_Z_Flatstart20/xwbir/RO100/TB2000

../tools-bip/step-xbil -NUMMIXES 20 -ROVAL 100 -TBVAL 2000 \ $PWD/FBK_D_A_Z_Init20/mono hmm14 FBK_D_A_Z_Init20/xwbir/RO100/TB2000

../tools-bip/step-xbir -NUMMIXES 20 -ROVAL 100 -TBVAL 2000 \ $PWD/MFC_E_D_A_Z_Flatstart20/mono hmm14 MFC_E_D_A_Z_Flatstart20/xwbir/RO100/TB2000

../tools-bip/step-xbir -NUMMIXES 20 -ROVAL 100 -TBVAL 2000 \ $PWD/MFC_E_D_A_Z_Init20/mono hmm14 MFC_E_D_A_Z_Init20/xwbir/RO100/TB2000

../tools-bip/step-xbir -NUMMIXES 20 -ROVAL 100 -TBVAL 2000 \ $PWD/FBK_D_A_Z_Flatstart20/mono hmm14 FBK_D_A_Z_Flatstart20/xwbir/RO100/TB2000

../tools-bip/step-xbir -NUMMIXES 20 -ROVAL 100 -TBVAL 2000 \ $PWD/FBK_D_A_Z_Init20/mono hmm14 FBK_D_A_Z_Init20/xwbir/RO100/TB2000

#TODO
#Decoding Biphones without options RIGHT 
cd MLSALT2/pracgmm/exp
for file in MFC_E_D_A_Z_Init20 MFC_E_D_A_Z_Flatstart20 FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20
	do
	for tb in 4000 
	do
	for i in $(seq 2 2 20)
	do

	hmm=hmm${i}4
	filename=decode-xwbir-$hmm
	echo $file $filename $tb
	../tools/steps/step-decode -CORETEST $PWD/$file/xwbir/RO100/TB$tb $hmm $file/xwbir/RO100/TB$tb/CORETEST/$filename
	echo $file $filename $tb $100 CORETEST >>bir${tb}.txt
	grep -A2 -P 'SENT' $file/xwbir/RO100/TB$tb/CORETEST/$filename/test/LOG >>bir${tb}.txt
	
done
done
done

cd MLSALT2/pracgmm/exp
for file in MFC_E_D_A_Z_Init20 MFC_E_D_A_Z_Flatstart20 FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20
	do
	for tb in 2000 
	do
	for i in $(seq 2 2 20)
	do

	hmm=hmm${i}4
	filename=decode-xwbir-$hmm
	echo $file $filename $tb
	../tools/steps/step-decode -CORETEST $PWD/$file/xwbir/RO100/TB$tb $hmm $file/xwbir/RO100/TB$tb/CORETEST/$filename
	echo $file $filename $tb $100 CORETEST >>bir${tb}.txt
	grep -A2 -P 'SENT' $file/xwbir/RO100/TB$tb/CORETEST/$filename/test/LOG >>bir${tb}.txt
	
done
done
done

#TODO
#Decoding Biphones without options LEFT 
cd MLSALT2/pracgmm/exp
for file in MFC_E_D_A_Z_Init20 MFC_E_D_A_Z_Flatstart20 FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20
	do
	for tb in 4000 
	do
	for i in $(seq 2 2 20)
	do

	hmm=hmm${i}4
	filename=decode-xwbil-$hmm
	echo $file $filename $tb
	../tools/steps/step-decode -CORETEST $PWD/$file/xwbil/RO100/TB$tb $hmm $file/xwbil/RO100/TB$tb/CORETEST/$filename
	echo $file $filename $tb $100 CORETEST >>bil${tb}.txt
	grep -A2 -P 'SENT' $file/xwbil/RO100/TB$tb/CORETEST/$filename/test/LOG >>bil${tb}.txt
	
done
done
done

cd MLSALT2/pracgmm/exp
for file in MFC_E_D_A_Z_Init20 MFC_E_D_A_Z_Flatstart20 FBK_D_A_Z_Init20 FBK_D_A_Z_Flatstart20
	do
	for tb in 2000 
	do
	for i in $(seq 2 2 20)
	do

	hmm=hmm${i}4
	filename=decode-xwbil-$hmm
	echo $file $filename $tb
	../tools/steps/step-decode -CORETEST $PWD/$file/xwbil/RO100/TB$tb $hmm $file/xwbil/RO100/TB$tb/CORETEST/$filename
	echo $file $filename $tb $100 CORETEST >>bil${tb}.txt
	grep -A2 -P 'SENT' $file/xwbil/RO100/TB$tb/CORETEST/$filename/test/LOG >>bil${tb}.txt
	
done
done
done
