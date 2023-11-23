#TOSTART: uvicorn main:app --reload
from fastapi import FastAPI, Request
from pydantic import BaseModel
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse
from time import sleep
import threading

app = FastAPI(__name__)
audio_file=None
speeched_list = []
succeed = " ."
studentname, yeargroup, lane, unregistered_lane, unregistered_plate = None, None, None, None, None

templates = Jinja2Templates(directory="templates")

new_data = {
    "studentname": studentname,
    "yeargroup": yeargroup,
    "speeched_list": speeched_list,
    "lane": lane,
    "success": succeed,
    "unregistered_plate": unregistered_plate,
    "unregistered_lane": unregistered_lane,
    "audio_file": audio_file
}

#TODO: Ensure Correct Data Types
class DATA(BaseModel):
    studentname: str
    yeargroup: int
    speeched_list: int
    lane: str
    success: str
    unregistered_plate: str
    unregistered_lane: str
    audio_file: str


@app.get("/")
def hello_world(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})


@app.get('/api/data')
def get_data():
    data = DATA(**new_data)
    return data

def start_web():
    '''
    t1 = threading.Thread(target=app.run)
    t1.start()
    '''
    app.run()

def get_sound_file(filename=None):
    global audio_file
    audio_file=filename
    sleep(1)
    audio_file = None

def get_vars(read,success):
    global speeched_list, succeed
    speeched_list=read
    succeed= success
    change_vars()

def change_vars():
    global studentname, yeargroup, lane, unregistered_plate, unregistered_lane
    try:
            if succeed: 
                print("yes")
                if speeched_list[-1].count("Year") +  speeched_list[-1].count("Pre School")==1:
                    studentname, yeargroup, lane = speeched_list[-1].split(',')
                elif speeched_list[-1].count("Year")+  speeched_list[-1].count("Pre School") ==2:
                    item_cache = speeched_list[-1].split(',')
                    studentname = f"{item_cache[0]}, {item_cache[2]}"
                    yeargroup = f"{item_cache[1]}, {item_cache[3]}"
                    lane = item_cache[-1]
                elif speeched_list[-1].count("Year") +  speeched_list[-1].count("Pre School")==3:
                    item_cache = speeched_list[-1].split(',')
                    studentname = f"{item_cache[0]}, {item_cache[2]}, {item_cache[4]}"
                    yeargroup = f"{item_cache[1]}, {item_cache[3]}, {item_cache[5]}"
                    lane = item_cache[-1]
                elif speeched_list[-1].count("Year") +  speeched_list[-1].count("Pre School")==4:
                    item_cache = speeched_list[-1].split(',')
                    studentname = f"{item_cache[0]}, {item_cache[2]}, {item_cache[4]}, {item_cache[6]}"
                    yeargroup = f"{item_cache[1]}, {item_cache[3]}, {item_cache[5]}, {item_cache[7]}"
                    lane = item_cache[-1]
                unregistered_plate, unregistered_lane = None, None
                sleep(5)
            else:
                print("else")
                studentname, yeargroup, lane =None, None, None
                unregistered_plate, unregistered_lane = speeched_list[-1].split(",")
    except:
                print("except")
                studentname, yeargroup, lane =None, None, None
                unregistered_plate, unregistered_lane = None, None
