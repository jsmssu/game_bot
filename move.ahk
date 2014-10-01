root_path := "C:\Users\silvia\Desktop\samtong"
number_path = %root_path%\coord_number_png
map_path = %root_path%\map
state_path = %root_path%\state
carrying_path = %root_path%\carrying_img
making_path = %root_path%\making_img

magic := {"귀환":"Z"}

;#     #       #       ######     #     #       #       #     #    ####### 
;##   ##      # #      #     #    ##    #      # #      ##   ##    #       
;# # # #     #   #     #     #    # #   #     #   #     # # # #    #       
;#  #  #    #     #    ######     #  #  #    #     #    #  #  #    #####   
;#     #    #######    #          #   # #    #######    #     #    #       
;#     #    #     #    #          #    ##    #     #    #     #    #       
;#     #    #     #    #          #     #    #     #    #     #    ####### 

;맵네임보드의 한계 좌표를 구한다.
get_map_board()
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
size_my_coord_queue := 10
clear_my_coord_queue()
{
    global my_coord_queue
    my_coord_queue := array()
}
update_my_coord_queue(Byref x, Byref y)
{ 
    global my_coord_queue
    global size_my_coord_queue
    index := size_my_coord_queue
    while(index)
	{
        index := index - 1
        index_b := index-1
        my_coord_queue.insert(%index%, my_coord_queue.index_b)
    }
    my_coord_queue[0] := x*1000 + y
}
is_all_same_my_coord_queue(Byref check_size="")
{
    global my_coord_queue
    global size_my_coord_queue
    
    if (check_size = "")
    {
        loop_number := size_my_coord_queue - 1
    }
    else 
    {
        loop_number := check_size - 1
    }
    

    index := 0
    loop %loop_number%
    {
        index_b := index + 1

        if (my_coord_queue[index] = my_coord_queue[index_b])
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


moving_direction := "s"
p_x = ""
p_y = ""
move_random()
{
    global moving_direction
    Random, ramdom_tmp, 0, 1

    if ((moving_direction = "l") or (moving_direction = "r"))
    {
        if (ramdom_tmp = 0)
	    {
		    controlsend, ,{up} , 바람의나라
		    return
	    }
	    if (ramdom_tmp = 1)
	    {
		    controlsend, ,{down} , 바람의나라
	    }   
	}
	else if ((moving_direction = "u") or (moving_direction = "d"))
	{
		if (ramdom_tmp = 0)
	    {
		    controlsend, ,{right} , 바람의나라
		    return
	    }
	    if (ramdom_tmp = 1)
	    {
		    controlsend, ,{left} , 바람의나라
	    }
	} 
}

move_one_step()
{
    global moving_direction

    if(moving_direction = "l")
    {
		controlsend, ,{left} , 바람의나라
	}
	else if(moving_direction = "r")
	{
		controlsend, ,{right} , 바람의나라
	}
    else if(moving_direction = "u")
	{
		controlsend, ,{up} , 바람의나라
	}
    else if(moving_direction = "d")
	{
		controlsend, ,{down} , 바람의나라
	}
}

move(Byref x, Byref y, Byref map_name:="", Byref gap:=0)
{ 
    global p_x
    global p_y

    global moving_direction
    global direction

    moving_direction := "g"
    
    x_range_low := x - gap
    x_range_high := x + gap
    y_range_low := y - gap
    y_range_high := y + gap

    time_moving  := 50
    p_x := getX()
    p_y := getY()
    clear_my_coord_queue()
    update_my_coord_queue(p_x,p_y)
    direction := "x"
    Settimer, CATCH_MY_COORD,200
	loop
	{  

        ; 좌표를 읽을 수 없을 때 리턴, ex)세계지도에 들어갔을때
        ; 원하는 맵에 다 왔을때
        ; 목적지에 정확히 갔을때 리턴
         
		if ( (moving_direction = "s") or (p_x = -1 or p_y = -1) or (map_name != "" and is_the_map(map_name) = 0) or (x_range_low <= p_x and x_range_high >= p_x and y_range_low <= p_y and y_range_high >= p_y))
		{
            MsgBox 멈춤
            moving_direction := "s"
            Settimer, CATCH_MY_COORD,off
			return 0
		}

        
        if (direction = "x")
        {
            if(p_x > x)
	        {
		        moving_direction := "l"
	        }
	        else if(p_x < x)
	        {
		        moving_direction := "r"
	        } 
            else
            {
                direction := "y"
            }
        } 
        if (direction = "y")
        {
            if(p_y > y)
	        {
		        moving_direction := "u"
	        }
	        else if(p_y < y)
	        {
		        moving_direction := "d"
	        }
            else
            {
                direction := "x"
            }
        } 

        if(is_all_same_my_coord_queue(4) = 0)
        {
            if (x_range_low <= p_x and x_range_high >= p_x and y_range_low <= p_y and y_range_high >= p_y)
            {
                move_random()
                sleep %time_moving%
            }
        }

        move_one_step()
        sleep %time_moving%
        
	}
	return -1
}
f1::
get_map_board()
return
f2::
;move(4,13,"동부여성")
move(10,8)
return
f3::
exitapp
return
 


CATCH_MY_COORD:
global p_x
global p_y
global direction
p_x := getX()
p_y := getY()
update_my_coord_queue(p_x,p_y)
if (is_all_same_my_coord_queue(4) = 0) 
{
    if (direction = "x")
    {
        direction := "y"
    }
    else if (direction = "y")
    {
        direction := "x"
    }
}
return
 