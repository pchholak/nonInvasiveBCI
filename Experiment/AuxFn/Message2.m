function Message2(k, timeInstr)
CellText = {'Now our task is to concentrate',...
            'on the cube center.',...
            'During the demonstration, front face of the cube',...
            'will continously flicker.',...
            'Try not to blink.',...
            ' ',...
            'And, if you feel any inconvenience,',...
            'close your eyes and let the assistant know about this.',...
            ' ',...
            'We shall start in a few seconds...',...
            };
cgalign('c','c'); cgpencol([1 1 1]); cgfont('Arial',fix(30*k));

del = 40; tempR = 230;

for i=1:length(CellText)
cgtext(CellText{i},0,fix(tempR*k));
tempR = tempR-del;
end
cgflip([0 0 0]);
pause(timeInstr);
