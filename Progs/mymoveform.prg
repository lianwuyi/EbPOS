PROCEDURE getMousePos (x, Y)
 LOCAL lcBuffer
 lcBuffer = REPLICATE(CHR(0), 8)
 = GetCursorPos (@lcBuffer)
 x = buf2dword(SUBSTR(lcBuffer, 1,4))
 Y = buf2dword(SUBSTR(lcBuffer, 5,4))
ENDPROC

FUNCTION buf2dword (lcBuffer)
 RETURN ASC(SUBSTR(lcBuffer, 1,1)) + ;
 ASC(SUBSTR(lcBuffer, 2,1)) * 256 +;
 ASC(SUBSTR(lcBuffer, 3,1)) * 65536 +;
 ASC(SUBSTR(lcBuffer, 4,1)) * 16777216
ENDFUNC
