#--put the rights modes and permissions for the files
chown root:root AcuAccess* acutools.cfg
chmod u+r,u+w,g-r,g-w,o-r,o-w AcuAccess*
chmod u+r,u+w,g-w,o-w acutools.cfg
chmod u+x,g+x *.sh
chmod -R 777 tmp
chown [local-user(s):local-user(s)-group] pcompile.sh
