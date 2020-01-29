%NavonTest

clear all

close all

%% Operating Initializations for: Keyboard responses, Sounds, IOPort, Screen %%
%Setting up basic operations for MATLAB EEG Experiment
%Coded by Alex Tran, PhD, (c) 2018
%Questions? 9trana@gmail.com, a_tran@hotmail.com

%****Keyboard****%

%Sets the default numerical codes for each key button-press on the keyboard; 
KbName('UnifyKeyNames');

%Defines the 3 variables for: checking if the key is down, the time at 
%keyboard check, and numerical code of the key that was pressed
[keyIsDown,keysecs,keyCode]=KbCheck;

%****Sound****%

%Sound card preparation
InitializePsychSound;

%Sets a call-able handle 'audhand' to the audio operations
audhand = PsychPortAudio('Open', [], [], 0, 48000, 2);

%****IOPort****%

%Creates a virtual serial port with call-able handle 'TPort' based on COM3 
%(check in Device Manager what the identity of the serial port is when 
%connecting the trigger box to confirm)

% [TPort]=IOPort('OpenSerialPort','COM1','FlowControl=Hardware(RTS/CTS lines) SendTimeout=1.0 StopBits=1');

%****Screen****%
%Defines the basic colours of the screen: white, grey and black
%Other colours MUST BE DEFINED if you would like to use them
white = WhiteIndex(0);
grey = white / 2;
black = BlackIndex(0);

%Initializes the screen, gives the screen the call-able handle 'nwind' and
%sets the variable 'rect' to be the screen resolution.
%rect is a 4-column variable with the 3rd-column being the width, and the 
%4th-column is the height it also fills the screen white (which was defined above)
[nwind, rect]=Screen('OpenWindow',0,white);

%Sets default text size for the 'nwind' screen handle
Screen('TextSize',nwind, 40);

%These variables determine the center of the screen based on the 'rect'
%variable and names them as v_res (vertical resolution) and h_res
%(horizontal), it also determines the center point of vertical and
%horizontal
v_res = rect(4);
h_res = rect(3);
v_center = v_res/2;
h_center = h_res/2;

%Assigns 'fixation' to be a variable representing the center of the screen
fixation = [h_center-10 v_center-10];
KbQueueCreate; 
KbQueueStart;

i=1;
for i=1:13
        navonfile(i)= sprintf("NvnF (%d).png",i); %Change prefix to be
        navonchar=char(navonfile(1,i));
        nvnimg{1,i}=imread(navonchar);        
end
i=1;
%practice
DrawFormattedText(nwind, ['For this next task, you will be presented with a series of letters. \n\n These letters will be made'...
    ' up of other letters and your task \n \n is to respond quickly with a button press.'...
    ' You will press \n\n the ''Z'' key if you saw the smaller letters more clearly, or \n\n the ''/?'' key'...
    ' if you saw the larger letter more clearly. \n\n You will see one example image, then perform 3 practice trials. \n\n Press any key to begin!'],  'center'  ,'center', black);
Screen('Flip', nwind,[],1);
KbStrokeWait;
        Screen('FillRect', nwind, white);
        Screen('Flip',nwind);
        nvnimgshow=Screen('MakeTexture', nwind, nvnimg{1,7});
        Screen('DrawTexture', nwind, nvnimgshow, [], [], 0);
        Screen('Flip',nwind);
        WaitSecs(.3);
        Screen('FillRect', nwind, white);
        Screen('Flip',nwind);
        DrawFormattedText(nwind, ['That was an example of the image you will see. \n\n If you saw the letter ''C'' more clearly '...
            ' then you should press the ''Z'' button. \n\n If you saw the ''Y'' more clearly'...
            ' then you should press the ''/?'' button. \n\n The window that allows you to respond will be very short.'...
            ' \n\n You will now have 3 practice'...
            ' trials. Press any button to begin.'],  'center'  ,'center', black);
             Screen('Flip',nwind);
             KbStrokeWait;

for i=1:3
        
        
        Screen('FillRect', nwind, white);
        DrawFormattedText(nwind, '+',  'center'  ,'center', black);
        Screen('Flip', nwind,[],1);
        WaitSecs(.5);
        nvnimgshow=Screen('MakeTexture', nwind, nvnimg{1,i});
        Screen('DrawTexture', nwind, nvnimgshow, [], [], 0);
        starttime=Screen('Flip',nwind);
        %         IOPort('Write',TPort,???);
        WaitSecs(.3);
        Screen('FillRect', nwind, white);
        Screen('Flip',nwind);
        endtime=KbQueueWait(-1);
%         IOPort('Write',TPort,???);
        [keyIsDown,secs,keyCode]=KbCheck(-1);
         x=find(keyCode>0);
         timing=endtime-starttime;
         if timing > .8
             DrawFormattedText(nwind, ['Your response was a bit too slow. Go with your gut response!\n\n Press any button to continue.'],  'center'  ,'center', black);
             Screen('Flip',nwind);
             KbStrokeWait;
         else
            switch x
                case 90
                 nvnprac(1,i)=1;
                 DrawFormattedText(nwind, ['You saw the small letters more clearly. Press any key to continue.'],  'center'  ,'center', black);
                    Screen('Flip',nwind);
                    KbStrokeWait;
                case 191
                 nvnprac(1,i)=2;
                 DrawFormattedText(nwind, ['You saw the large letter more clearly. Press any key to continue.'],  'center'  ,'center', black);
                    Screen('Flip',nwind);
                    KbStrokeWait;
                otherwise
                    DrawFormattedText(nwind, ['Invalid Key!'],  'center'  ,'center', black);
                    Screen('Flip',nwind);
                    WaitSecs(2);
            end
                    
         end
end
DrawFormattedText(nwind, ['Now you will perform the real trials, press \n\n any button when you are ready to begin!'],  'center'  ,'center', black);
Screen('Flip', nwind,[],1);
KbStrokeWait;

for i=4:13
        
        Screen('FillRect', nwind, white);
        DrawFormattedText(nwind, '+',  'center'  ,'center', black);
        Screen('Flip', nwind,[],1);
        WaitSecs(.5);
        nvnimgshow=Screen('MakeTexture', nwind, nvnimg{1,i});
        Screen('DrawTexture', nwind, nvnimgshow, [], [], 0);
        starttime=Screen('Flip',nwind);
        %         IOPort('Write',TPort,???);
        WaitSecs(.5);
        Screen('FillRect', nwind, white);
        Screen('Flip',nwind);
        endtime=KbQueueWait(-1);
%         IOPort('Write',TPort,???);
        [keyIsDown,secs,keyCode]=KbCheck(-1);
         x=find(keyCode>0);
         timing=endtime-starttime;
         if timing > .8
             DrawFormattedText(nwind, ['Too Slow! Press any button to continue.'],  'center'  ,'center', black);
             Screen('Flip',nwind);
             KbStrokeWait;
         else
            switch x
                case 90
                 nvnresp(1,i)=1;
                 DrawFormattedText(nwind, ['You saw the smaller letters more clearly. Press any key to continue.'],  'center'  ,'center', black);
                    Screen('Flip',nwind);
                    KbStrokeWait;
                case 191
                 nvnresp(1,i)=2;
                  DrawFormattedText(nwind, ['You saw the large letter more clearly. Press any key to continue.'],  'center'  ,'center', black);
                    Screen('Flip',nwind);
                    KbStrokeWait;
                otherwise
                    DrawFormattedText(nwind, ['Invalid Key!'],  'center'  ,'center', black);
                    Screen('Flip',nwind);
                    WaitSecs(3);
            end
                    
         end
end