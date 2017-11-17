MSG1="---- ----"
lsmenu()
{
    echo "\"adad asd2\" \"aaAS${MSG1}DA dsgFSG\" \"fdasdfsd fsd fsd\" \"fdsafda f sdf fsd\""
}
ASD=`sh -c "dialog --backtitle \"Install packages\" --title \"\" --stdout --menu \"Select packages\" 20 61 15 $(lsmenu)"`
echo $ASD
