

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