rm -r ./tmp/* >/dev/null 2>&1
rm *.err
type procob
if [ $? -eq 1 ]
then
  echo Oracle precompiler must be in the PATH !
  exit $?
fi
./permOk.sh
acuserve -start -c acutools.cfg -n [port-number] -le [acuserver's-log-file] -t 7
acurcl -start -c acutools.cfg -n [port-number] -le [acurcl's-log-file] -t 7

