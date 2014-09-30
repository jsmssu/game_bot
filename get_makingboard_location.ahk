;생산보드의 한계 좌표를 구한다.
get_saensan_board()
{
    global making_path
    global left_top_x
    global left_top_y

    global right_bottom_x
    global right_bottom_y


    ImageSearch, left_top_x, left_top_y, 0, 0, 1200, 1200, *Trans0000FF %making_path%/생산판왼위.png

    if (ErrorLevel = 0)
    {
        ImageSearch, right_bottom_x, right_bottom_y, 0, 0, 1200, 1200, *Trans0000FF %making_path%/생산판오아.png
        return 0
    }
    return -1
}