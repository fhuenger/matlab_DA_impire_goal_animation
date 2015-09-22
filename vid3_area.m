% function vid3_area(ht,frames)
%% erzeugt ein Video der Spielszene
% benötigt team/ball-daten, sowie tw_team-daten
% vid3_daten_in_m;

% save_path = 'C:\Users\irrer-ire\Desktop\statistik_neu3\';
% m_path = 'C:\Users\irrer-ire\Desktop\diplomarbeit\neu\sortierung\structures\KS_u_li\functions\';


%% evalin
ht = evalin('base','ht');
frames = evalin('base','frames');
team = evalin('base','team');
if ht == 1;
    vid_ball_section_1 = evalin('base','vid_ball_section_1');
    vid_tw_team_1_1_x = evalin('base','vid_tw_team_1_1_x');
    vid_tw_team_1_1_y = evalin('base','vid_tw_team_1_1_y');
    vid_tw_team_2_1_x = evalin('base','vid_tw_team_2_1_x');
    vid_tw_team_2_1_y = evalin('base','vid_tw_team_2_1_y');
    vid_team_1_1_x = evalin('base','vid_team_1_1_x');
    vid_team_1_1_y = evalin('base','vid_team_1_1_y');
    vid_team_2_1_x = evalin('base','vid_team_2_1_x');
    vid_team_2_1_y = evalin('base','vid_team_2_1_y');
elseif ht == 2;
    vid_ball_section_2 = evalin('base','vid_ball_section_2');
    vid_tw_team_1_2_x = evalin('base','vid_tw_team_1_2_x');
    vid_tw_team_1_2_y = evalin('base','vid_tw_team_1_2_y');
    vid_tw_team_2_2_x = evalin('base','vid_tw_team_2_2_x');
    vid_tw_team_2_2_y = evalin('base','vid_tw_team_2_2_y');
    vid_team_1_2_x = evalin('base','vid_team_1_2_x');
    vid_team_1_2_y = evalin('base','vid_team_1_2_y');
    vid_team_2_2_x = evalin('base','vid_team_2_2_x');
    vid_team_2_2_y = evalin('base','vid_team_2_2_y');
end

% ht = 1;
% frames = 61424:61924;

h = figure(1);

if ht == 1;
    g1(1,1:11) = ones(1,11);
    g2 = g1+1;
    if team == 1;
        c1 = convhull(vid_tw_team_1_1_x(1,:),vid_tw_team_1_1_y(1,:))';
        x_t1_area = vid_tw_team_1_1_x(1,c1);
        y_t1_area = vid_tw_team_1_1_y(1,c1);
    elseif team == 2;
        c1 = convhull(vid_tw_team_2_1_x(1,:),vid_tw_team_2_1_y(1,:))';
        x_t1_area = vid_tw_team_2_1_x(1,c1);
        y_t1_area = vid_tw_team_2_1_y(1,c1);
    end
    x_b = vid_ball_section_1(frames(1),1);
    y_b = vid_ball_section_1(frames(1),2);
    x_t1 = vid_team_1_1_x(frames(1),1:11);
    y_t1 = vid_team_1_1_y(frames(1),1:11);
    x_t2 = vid_team_2_1_x(frames(1),1:11);
    y_t2 = vid_team_2_1_y(frames(1),1:11);
    i = imread('fb_feld_01.png'); hold on;
    imagesc(24:133.5,8:94,i);
    gs_t1_area = fill(x_t1_area,y_t1_area,'b'); hold on;
    gs_b = gscatter(x_b,y_b); hold on;
    set(gs_b,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',2);
    gs_t1 = gscatter(x_t1,y_t1,g1); hold on;
    set(gs_t1,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',4);
    gs_t2 = gscatter(x_t2,y_t2,g2);
    set(gs_t2,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',4);
    legend off;
    count = length(frames);
    nextframe=1;
    s = size(frames,2);
    M(s) = struct('cdata',[],'colormap',[]);
    set(gca,'XLim',[26.25 131.25],'YLim',[17 85],'XTick',(26.25:52.5:131.25),'YTick',...
        (17:34:85),'XTickLabel',{'0';'52.5';'105'},'YTickLabel',{'0';'34';'68'},...
        'NextPlot','ReplaceChildren');
    xlabel('x (Spielfeldlänge in m)');
    ylabel('y (Spielfeldlänge in m)');
    axis manual;

    for k = 1:count;
        abc = frames(1) - 1;
        i = abc + k;
        n = 1:11;
        if team == 1;
            c1 = convhull(vid_tw_team_1_1_x(k,:),vid_tw_team_1_1_y(k,:))';
            x_t1_area = vid_tw_team_1_1_x(k,c1);
            y_t1_area = vid_tw_team_1_1_y(k,c1);
        elseif team == 2;
            c1 = convhull(vid_tw_team_2_1_x(k,:),vid_tw_team_2_1_y(k,:))';
            x_t1_area = vid_tw_team_2_1_x(k,c1);
            y_t1_area = vid_tw_team_2_1_y(k,c1);
        end
        x_t1 = vid_team_1_1_x(i,n);
        x_t2 = vid_team_2_1_x(i,n);
        y_t1 = vid_team_1_1_y(i,n);
        y_t2 = vid_team_2_1_y(i,n);
        x_b = vid_ball_section_1(i,1);
        y_b = vid_ball_section_1(i,2);
        set(gs_t1_area,'XData',x_t1_area,'YData',y_t1_area);    
        set(gs_b,'XData',x_b,'YData',y_b);    
        set(gs_t1,'XData',x_t1,'YData',y_t1);
        set(gs_t2,'XData',x_t2,'YData',y_t2);
        M(nextframe)=getframe(h);
        nextframe=nextframe+1;
    end
elseif ht == 2;
    g1(1,1:11) = ones(1,11);
    g2 = g1+1;
    if team == 1;
        c1 = convhull(vid_tw_team_1_2_x(1,:),vid_tw_team_1_2_y(1,:))';
        x_t1_area = vid_tw_team_1_2_x(1,c1);
        y_t1_area = vid_tw_team_1_2_y(1,c1);
    elseif team == 2;
        c1 = convhull(vid_tw_team_2_2_x(1,:),vid_tw_team_2_2_y(1,:))';
        x_t1_area = vid_tw_team_2_2_x(1,c1);
        y_t1_area = vid_tw_team_2_2_y(1,c1);
    end
    x_b = vid_ball_section_2(frames(1),1);
    y_b = vid_ball_section_2(frames(1),2);
    x_t1 = vid_team_1_2_x(frames(1),1:11);
    y_t1 = vid_team_1_2_y(frames(1),1:11);
    x_t2 = vid_team_2_2_x(frames(1),1:11);
    y_t2 = vid_team_2_2_y(frames(1),1:11);
    i = imread('fb_feld_01.png');
    imagesc(24:133.5,8:94,i); hold on;
    gs_t1_area = fill(x_t1_area,y_t1_area,'b'); hold on;
    gs_b = gscatter(x_b,y_b); hold on;
    set(gs_b,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',2);
    gs_t1 = gscatter(x_t1,y_t1,g1); hold on;
    set(gs_t1,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor','r','MarkerSize',4);
    gs_t2 = gscatter(x_t2,y_t2,g2);
    set(gs_t2,'Marker','o','MarkerEdgeColor','k','MarkerFaceColor','b','MarkerSize',4);
    legend off;
    
    count = length(frames);
    nextframe=1;
    s = size(frames,2);
    M(s) = struct('cdata',[],'colormap',[]);
    set(gca,'XLim',[26.25 131.25],'YLim',[17 85],'XTick',(26.25:52.5:131.25),'YTick',...
        (17:34:85),'XTickLabel',{'0';'52.5';'105'},'YTickLabel',{'0';'34';'68'},...
        'NextPlot','ReplaceChildren');
    xlabel('x (Spielfeldlänge in m)');
    ylabel('y (Spielfeldlänge in m)');
    axis manual;

    for k = 1:count;
        abc = frames(1) - 1;
        i = abc + k;
        n = 1:11;
        if team == 1;
            c1 = convhull(vid_tw_team_1_2_x(k,:),vid_tw_team_1_2_y(k,:))';
            x_t1_area = vid_tw_team_1_2_x(k,c1);
            y_t1_area = vid_tw_team_1_2_y(k,c1);
        elseif team == 2;
            c1 = convhull(vid_tw_team_2_2_x(k,:),vid_tw_team_2_2_y(k,:))';
            x_t1_area = vid_tw_team_2_2_x(k,c1);
            y_t1_area = vid_tw_team_2_2_y(k,c1);
        end
        x_t1 = vid_team_1_2_x(i,n);
        x_t2 = vid_team_2_2_x(i,n);
        y_t1 = vid_team_1_2_y(i,n);
        y_t2 = vid_team_2_2_y(i,n);
        x_b = vid_ball_section_2(i,1);
        y_b = vid_ball_section_2(i,2);
        set(gs_t1_area,'XData',x_t1_area,'YData',y_t1_area);    
        set(gs_b,'XData',x_b,'YData',y_b);    
        set(gs_t1,'XData',x_t1,'YData',y_t1);
        set(gs_t2,'XData',x_t2,'YData',y_t2);
        M(nextframe)=getframe(h);
        nextframe=nextframe+1;
    end
end
cd(save_path);
movie2avi(M, '138312_1_0_64769_65019.avi', 'compression', 'none', 'fps', 25, 'quality', 100); 
cd(m_path);
% end