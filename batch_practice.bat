@echo off

set /a index=0

:loop
	echo Current index: %index%
	set /p input="�Է�: "

	echo Input: %input%
	set arr[%index%]=%input%
	call echo %%arr[%index%]%%

	if %input%==q (
		set arr[%index%]=
		goto loop_end
	) else (
		set /a index+=1
	)
	goto loop
:loop_end

echo === ��� ��� ���� ===
set /a at=0
:loop_list
	if defined arr[%at%] (
		call echo %%arr[%at%]%%
		set /a at+=1
		goto loop_list
	)
echo === ��� ��� �� ===

pause