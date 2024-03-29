C:Zabbix\bin\zabbix_agentd.exe --stop
mkdir C:\zabbix-agent4.0
xcopy /s /E /I /y C:\zabbix C:\zabbix-agent4.0
C:\zabbix\bin\zabbix_agentd.exe -d
C:\zabbix\zabbix_agentd.exe -d
rmdir /S /Q C:\zabbix
mkdir C:\Zabbix
xcopy /s /E /I /y Zabbix C:\Zabbix
C:Zabbix\bin\zabbix_agentd.exe -i -c C:\Zabbix\conf\zabbix_agentd.conf
C:Zabbix\bin\zabbix_agentd.exe --start
exit