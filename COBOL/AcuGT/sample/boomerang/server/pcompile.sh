#--please do not save this file with a Windows editor
returnCode=0
cd tmp/$4
exec >pcompile.sh.out 2>&1; set -x
gzip -d sources.vio.gz
vio -ivnf sources.vio >listSources.txt
lstSources=`cat listSources.txt`
for fic in $lstSources
do
  mv $fic\ * $fic
done
procob include=. oname=$1.$3 $1.$2 >$1.out
returnCode=$?
echo $1.out >listResults.txt
echo $1.$3 >>listResults.txt
echo pcompile.sh.out >>listResults.txt
vio -oblf listResults.txt results.vio
gzip -f results.vio
rm sources.vio
for fic in $lstSources
do
  rm $fic
done
rm $1.*
exit $returnCode
