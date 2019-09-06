echo off
for /f %%i in ('"C:\Program Files\Git\usr\bin\cygpath.exe" %cd%') do set CWD=%%i
REM docker run --rm -it -v:%CWD%/:/var/nvim-edit nvim
docker run --rm -it --mount type=bind,source=%CWD%/,target=/var/nvim-edit nvim nvim %*
