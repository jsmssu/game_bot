;���꺸���� �Ѱ� ��ǥ�� ���Ѵ�.
get_saensan_board()
{
    global making_path
    global left_top_x
    global left_top_y

    global right_bottom_x
    global right_bottom_y


    ImageSearch, left_top_x, left_top_y, 0, 0, 1200, 1200, *Trans0000FF %making_path%/�����ǿ���.png

    if (ErrorLevel = 0)
    {
        ImageSearch, right_bottom_x, right_bottom_y, 0, 0, 1200, 1200, *Trans0000FF %making_path%/�����ǿ���.png
        return 0
    }
    return -1
}