import os
def get_input():
    try:
        ram_usage=float(input("Please Enter RAM Usage Percent [0,100]"))
        hard_usage = float(input("Please Enter HARD Usage Percent [0,100]"))
        cpu_usage = float(input("Please Enter CPU Usage Percent [0,100]"))
        return [ram_usage,hard_usage,cpu_usage]
    except Exception as e:
        print(e)

def read_ref():
    try:
        hard_list=[]
        ram_list=[]
        cpu_list=[]
        list_dir=os.listdir()
        if "hard.ref" not in list_dir:
            raise Exception("There is no ref file for hard disk")
        elif "ram.ref" not in list_dir:
            raise Exception("There is no ref file for hard ram")
        elif  "cpu.ref" not in list_dir:
            raise Exception("There is no ref file for hard cpu")
        else:
            pass
        ram_file=open("ram.ref","r")
        hard_file=open("hard.ref","r")
        cpu_file=open("cpu.ref","r")
        user_input = get_input()
        ram_total=[]
        hard_total=[]
        cpu_total=[]
        for index,line in enumerate(ram_file):
            temp=line.strip().split(",")
            if len(temp)!=3:
                print("[Warning] RAM Ref File Out Of Format In Line "+str(index))
            ram_list.append(temp)
            ram_total.append((float(temp[1])*user_input[0]/100)+(float(temp[2])*(1-user_input[0]/100)))
        for index,line in enumerate(hard_file):
            temp = line.strip().split(",")
            if len(temp)!=3:
                print("[Warning] HARD Ref File Out Of Format In Line "+str(index))
            hard_list.append(temp)
            hard_total.append((float(temp[1]) * user_input[1] / 100) + float(temp[2]) * (1 - user_input[1] / 100))
        for index,line in enumerate(cpu_file):
            temp = line.strip().split(",")
            if len(temp)!=3:
                print("[Warning] CPU Ref File Out Of Format In Line "+str(index))
            cpu_list.append(temp)
            cpu_total.append((float(temp[1]) * user_input[2] / 100) + float(temp[2]) * (1 - user_input[2] / 100))
        print("RAM :"+ram_list[ram_total.index(min(ram_total))][0])
        print("RAM :" + cpu_list[cpu_total.index(min(cpu_total))][0])
        print("RAM :" + hard_list[hard_total.index(min(hard_total))][0])
        print("Total :"+str(min(cpu_total)+min(ram_total)+min(hard_total))+" W")



    except Exception as e:
        print(e)


if __name__=="__main__":
    read_ref()




