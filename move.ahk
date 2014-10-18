root_path := "."
number_path = %root_path%\coord_number_png
map_path = %root_path%\map
state_path = %root_path%\state
carrying_path = %root_path%\carrying_img
making_path = %root_path%\making_img

magic := {"귀환":"Z"}





CoordMode, Pixel, Screen
CoordMode, Mouse, Screen



;#     #       #       ######    
;##   ##      # #      #     #   
;# # # #     #   #     #     #   
;#  #  #    #     #    ######    
;#     #    #######    #         
;#     #    #     #    #         
;#     #    #     #    #         

;맵보드의 한계 좌표를 구한다.
map_left_top_x := ""
map_left_top_y := ""
map_right_bottom_x := ""
map_right_bottom_y := ""
get_screen_board()
{
    global map_path
    global map_left_top_x
    global map_left_top_y

    global map_right_bottom_x
    global map_right_bottom_y

    ImageSearch, map_left_top_x, map_left_top_y, 0, 0, 1200, 1200, *Trans0000FF %map_path%/map_left_top.png
    if (ErrorLevel = 0)
    {
        ImageSearch, map_right_bottom_x, map_right_bottom_y, 0, 0, 1200, 1200, *Trans0000FF %map_path%/map_right_bottom.png
        if (ErrorLevel = 0)
        {
            return 0
        }
    }
    return -1
}



;#     #       #       ######     #     #       #       #     #    ####### 
;##   ##      # #      #     #    ##    #      # #      ##   ##    #       
;# # # #     #   #     #     #    # #   #     #   #     # # # #    #       
;#  #  #    #     #    ######     #  #  #    #     #    #  #  #    #####   
;#     #    #######    #          #   # #    #######    #     #    #       
;#     #    #     #    #          #    ##    #     #    #     #    #       
;#     #    #     #    #          #     #    #     #    #     #    ####### 

;맵네임보드의 한계 좌표를 구한다.
mapboard_left_top_x := ""
mapboard_left_top_y := ""
mapboard_right_bottom_x := ""
mapboard_right_bottom_y := ""
get_mapname_board()
{
    global map_path
    global mapboard_left_top_x
    global mapboard_left_top_y

    global mapboard_right_bottom_x
    global mapboard_right_bottom_y

    ImageSearch, mapboard_left_top_x, mapboard_left_top_y, 0, 0, 1200, 1200, *Trans0000FF %map_path%/mapname_left_top.png
    if (ErrorLevel = 0)
    {
        ImageSearch, mapboard_right_bottom_x, mapboard_right_bottom_y, 0, 0, 1200, 1200, *Trans0000FF %map_path%/mapname_right_bottom.png
        if (ErrorLevel = 0)
        {
            return 0
        }
    }
    return -1
}


is_the_map(Byref map_name)
{
	global map_path
    global mapboard_left_top_x
    global mapboard_left_top_y

    global mapboard_right_bottom_x
    global mapboard_right_bottom_y

    p := map_path . "\" . map_name . ".png"
	ImageSearch, FoundX, FoundY, %mapboard_left_top_x%, %mapboard_left_top_y%, %mapboard_right_bottom_x%, %mapboard_right_bottom_y%, %p%
	if(ErrorLevel = 0)
	{
		return 0
	}
	else
	{
		return -1
	}
}


; #####     #######    #######    #     #    #     # 
;#     #    #             #        #   #      #   #  
;#          #             #         # #        # #   
;#  ####    #####         #          #          #    
;#     #    #             #         # #         #    
;#     #    #             #        #   #        #    
; #####     #######       #       #     #       # 

;@example
;t := getX()
number_png := {0 : number_path . "\0.png", 1 : number_path . "\1.png", 2 : number_path . "\2.png", 3 : number_path . "\3.png", 4 : number_path . "\4.png", 5 : number_path . "\5.png", 6 : number_path . "\6.png", 7 : number_path . "\7.png", 8 : number_path . "\8.png", 9 : number_path . "\9.png"}
get_my_each_coord_number(coord_x)
{ 
	global number_png
	for key, value in number_png
	{
		coordx_x_end := coord_x + 9  
		ImageSearch, FoundX, FoundY, coord_x, 738, coordx_x_end, 749, *TransFFFFFF %value%
		if (ErrorLevel = 0)
		{
			return key
		}
	}
	return -1
}
getX()
{
	x0 := get_my_each_coord_number(930)
	x1 := get_my_each_coord_number(921)
	x2 := get_my_each_coord_number(912)
	if (x0 = -1 or x1 = -1 or x2 = -1)
	{
		return -1
	}
	else
	{
		return x0 + x1*10 + x2*100
	}
}
getY()
{
	y0 := get_my_each_coord_number(988)
	y1 := get_my_each_coord_number(979)
	y2 := get_my_each_coord_number(970)
	if (y0 = -1 or y1 = -1 or y2 = -1)
	{
		return -1
	}
	else
	{
		return y0 + y1*10 + y2*100
	}
}






; #####     #######    #######    ######     ######         #####     #     #    #######    #     #    ####### 
;#     #    #     #    #     #    #     #    #     #       #     #    #     #    #          #     #    #       
;#          #     #    #     #    #     #    #     #       #     #    #     #    #          #     #    #       
;#          #     #    #     #    ######     #     #       #     #    #     #    #####      #     #    #####   
;#          #     #    #     #    #   #      #     #       #   # #    #     #    #          #     #    #       
;#     #    #     #    #     #    #    #     #     #       #    #     #     #    #          #     #    #       
; #####     #######    #######    #     #    ######         #### #     #####     #######     #####     ####### 

;@example
;update_my_coord_queue(10,10)
;t := is_all_same_my_coord_queue()

my_coord_queue := array()
size_my_coord_queue := 5

my_direction_queue := array()
size_my_direction_queue := 5

clear_my_coord_queue()
{
    global my_coord_queue
    clear_queue(my_coord_queue)
}
update_my_coord_queue(Byref x, Byref y)
{
    global my_coord_queue
    global size_my_coord_queue
    update_queue(my_coord_queue, size_my_coord_queue, x, y)
}
is_all_same_my_coord_queue(Byref check_size="")
{
    global my_coord_queue
    global size_my_coord_queue
    re := is_all_same_queue(my_coord_queue, size_my_coord_queue, check_size)
    return re
}



clear_queue(Byref queue)
{
    queue =
    queue := array()
}
update_queue(Byref queue, Byref size_queue, Byref x, Byref y)
{ 
    index := size_queue
    while(index)
	{
        index := index - 1
        index_b := index-1
        queue.insert(%index%, queue.index_b)
    }
    queue[0] := x*1000 + y
}

is_all_same_queue(Byref my_queue, Byref size_queue, Byref check_size="")
{   
    global my_coord_queue
    
    if (check_size = "")
    {
        loop_number := size_queue - 1
    }
    else 
    {
        loop_number := check_size - 1
    }

    index := 0
    loop %loop_number%
    {
        index_b := index + 1

        if (my_queue[index] = my_queue[index_b])
        {
            index := index + 1
            continue
        }
        else
        {
            return -1
        }
    }
    return 0
} 






;#     #      ###      #     #    ####### 
;##   ##     #   #     #     #    #       
;# # # #    #     #    #     #    #       
;#  #  #    #     #    #     #    #####   
;#     #    #     #     #   #     #       
;#     #     #   #       # #      #       
;#     #      ###         #       ####### 


move_flag := "s"
direction_lrud := "l"
direction_xy := "x"
p_x = ""
p_y = ""
rightangle_direction()
{
    
    global direction_lrud
    global direction_xy
    Random, ramdom_tmp, 0, 1

    if (direction_xy = "x")
    {
        if (ramdom_tmp = 0)
	    {
		    return "u"
	    }
	    if (ramdom_tmp = 1)
	    {
            return "d"
	    }   
	}
	else if (direction_xy = "y")
	{
		if (ramdom_tmp = 0)
	    {
		    return "r"
	    }
	    if (ramdom_tmp = 1)
	    {
            return "l"
	    }
	} 
}


move_one_step()
{
    global direction_lrud

    if(direction_lrud = "l")
    {
		controlsend, ,{left} , 바람의나라
	}
	else if(direction_lrud = "r")
	{
		controlsend, ,{right} , 바람의나라
	}
    else if(direction_lrud = "u")
	{
		controlsend, ,{up} , 바람의나라
	}
    else if(direction_lrud = "d")
	{
		controlsend, ,{down} , 바람의나라
	}

}



goal_x := ""
goal_y := ""


;움직임의 시작과 끝만 알려준다.
move(Byref x,Byref y, Byref map_name:="", Byref gap:=0)
{ 
    global p_x
    global p_y
    global goal_x
    global goal_y
    global moving_map := map_name

    global direction_lrud
    global move_flag
    global direction_xy

    goal_x := x
    goal_y := y

    global x_range_low
    global x_range_high
    global y_range_low
    global y_range_high

    x_range_low := x - gap
    x_range_high := x + gap
    y_range_low := y - gap
    y_range_high := y + gap

    send {esc}
    sleep 100
    send {enter}
    sleep 100
    send MOVE
    sleep 100
    send {esc}
    sleep 100

    clear_my_coord_queue()
    p_x := getX()
    p_y := getY()
    update_my_coord_queue(p_x,p_y)

    

    direction_xy := "x"
    move_flag := "g"

    Settimer, CATCH_MY_COORD,100

    while (1)
    {  

        if (move_flag = "s")
        {
            Settimer, CATCH_MY_COORD,off
            return 0
        }
        sleep 100
    }
    return -1
}



Gui,Show,x200 y200 h100 w300, Gui

Gui,Add,Text,x0 y0 h20 w150,지진
Gui,Add,Text,x0 y20 h20 w150,힐
Gui,Add,Text,x0 y40 h20 w150,공력증강
Gui,Add,Text,x0 y60 h20 w150,귀환
Gui,Add,Text,x0 y80 h20 w150,비영사천문

Gui,Add,Edit,x150 y0 h20 w100 vattack,1
Gui,Add,Edit,x150 y20 h20 w100 vheal,2
Gui,Add,Edit,x150 y40 h20 w100 vgong,3
Gui,Add,Edit,x150 y60 h20 w100 vgui,4
Gui,Add,Edit,x150 y80 h20 w100 vbi,5

Gui,Add,Button,x250 y40 h20 w50 gWhySUBMMIT,확인
return

성1 := ["1", [[74, 24], [65, 24], [65, 28], [43, 29]]]
성2 := ["2", [[73, 27], [58, 27], [58, 29], [58, 29], [43, 29]]]
성3 := ["3", [[73, 29], [43, 29], [43, 29], [43, 28]]]
성4 := ["4", [[72, 29], [43, 29], [43, 28]]]
성5 := ["5", [[72, 27], [49, 29], [43, 29]]]
성6 := ["6", [[75, 29], [43, 29]]]
성7 := ["7", [[74, 29], [43, 30]]]
성8 := ["8", [[73, 29], [43, 29]]]
성9 := ["9", [[75, 29], [43, 29], [43, 28]]]
성10 := ["10", [[74, 29], [43, 29], [43, 28]]]


사슴굴1 := [[4, 13], [4, 11], [4, 10], [4, 8], [4, 7], [4, 7], [5, 7], [5, 6], [7, 6], [8, 6], [9, 6], [10, 6], [11, 6], [12, 6], [13, 6], [13, 6], [13, 7], [13, 8], [13, 9], [13, 10], [13, 11], [13, 12], [13, 13], [14, 13], [15, 13], [16, 13], [17, 13], [18, 13], [20, 13]]
사슴굴2 := [[6, 8], [7, 8], [7, 9], [7, 10], [7, 11], [7, 12], [7, 13], [7, 14], [7, 15], [7, 16], [7, 17], [7, 18], [7, 20], [7, 21], [7, 22], [7, 23], [7, 24], [7, 25], [8, 25], [10, 27], [10, 30]]
사슴굴3 := [[4, 8], [4, 9], [4, 10], [4, 11], [4, 12], [5, 12], [6, 12], [7, 12], [8, 12], [9, 12], [10, 12], [11, 12], [12, 12], [13, 12], [14, 12], [15, 12], [16, 12], [17, 12], [17, 14], [18, 14], [25, 14]]
사슴굴4 := [[5, 9], [8, 9], [10, 9], [12, 9], [13, 9], [14, 9], [15, 9], [16, 9], [16, 9], [17, 9], [18, 9], [19, 9], [19, 9], [20, 9], [21, 9], [22, 9], [23, 9], [24, 9], [25, 9], [25, 10], [25, 11], [25, 12], [25, 13], [25, 17]]
사슴굴5 := [[5, 8], [5, 10], [5, 11], [5, 12], [5, 13], [6, 13], [7, 13], [8, 13], [10, 13], [12, 13], [13, 13], [14, 13], [15, 13], [17, 13], [18, 13], [19, 13], [20, 13], [21, 13], [21, 12], [21, 11], [21, 8], [21, 7], [21, 6], [21, 5], [21, 4], [21, 3], [21, 2], [21, -1]]
사슴굴6 := [[13, 25], [11, 25], [9, 25], [8, 25] [7,25], [7,24], [7,22], [7,20], [7,17],  [18, 22], [13, 17], [13, 15], [13, 11], [13, 9], [12, 9], [10, 9], [7, 9], [5, 9]]



getRandomTime(Byref l, Byref h)
{
    Random, ramdom_tmp, %l%, %h%
    return %ramdom_tmp%
}

use_magic()
{
    global attack
    global gong
    controlsend, ,%attack% , 바람의나라
    sleep getRandomTime(100,300)
    controlsend, ,{right}, 바람의나라
    sleep getRandomTime(100,300)
    controlsend, ,{enter}, 바람의나라
    sleep getRandomTime(50,100)
    controlsend, ,%gong% , 바람의나라
    sleep getRandomTime(50,100)
}
moveToDest(map_start, Byref array_way,Byref end_x,Byref end_y)
{
    loop % array_way.MaxIndex()
    {
        move(array_way[A_index][1], array_way[A_index][2], %map_start%, 1)
    }
    move(end_x, end_y, %map_start%, 0)
}

f1::
moveToDest(1, [[73, 21], [72, 28], [43, 28]], 43, 27)
return

f2::
move_flag := "s"
return


; #####     #######    #######    ######     ######  
;#     #    #     #    #     #    #     #    #     # 
;#          #     #    #     #    #     #    #     # 
;#          #     #    #     #    ######     #     # 
;#          #     #    #     #    #   #      #     # 
;#     #    #     #    #     #    #    #     #     # 
; #####     #######    #######    #     #    ######  

CATCH_MY_COORD:
global move_flag
p_x := getX()
p_y := getY()
if ((moving_map != "" and is_the_map(moving_map) != 0)
        or (p_x = -1 and p_y = -1)) 
{
    move_flag := "s"
}

if (p_x != -1 and p_y != -1)
{
    update_my_coord_queue(p_x,p_y)
}


if (is_all_same_my_coord_queue(5) = 0) 
{
    if (x_range_low <= p_x and x_range_high >= p_x and y_range_low <= p_y and y_range_high >= p_y)
    {
         move_flag := "s"
    }
    else if (p_x = goal_x or p_y = goal_y)
    {
        direction_lrud := rightangle_direction()
        if (move_flag = "g")
        {
            move_one_step()
        }
        else
        {
            move_flag := "s"
            ;Settimer, CATCH_MY_COORD,off
        }
        return
    }
    else if (direction_xy = "x")
    {
        direction_xy:= "y"
    }
    else if (direction_xy = "y")
    {
        direction_xy:= "x"
    }
} 
if (p_x = goal_x and p_y = goal_y)
{
    move_flag := "s"
} 
else if(p_x = goal_x)
{
    direction_xy:= "y"
}
else if(p_y = goal_y)
{
    direction_xy:= "x"
}

if (direction_xy = "x")
{
    if(p_x > goal_x)
	{
		direction_lrud := "l"
	}
	else if(p_x < goal_x)
	{
		direction_lrud := "r"
	}
} 
else if (direction_xy = "y")
{
    if(p_y > goal_y)
	{
		direction_lrud := "u"
	}
	else if(p_y < goal_y)
	{
		direction_lrud := "d"
	}
} 

if (move_flag = "g")
{
    move_one_step()
}
else
{
    Settimer, CATCH_MY_COORD,off
}

return



WhySUBMMIT:
Gui, Submit
return
