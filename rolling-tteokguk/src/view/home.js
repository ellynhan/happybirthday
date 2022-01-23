import { $ } from '../utils/selector.js';
import Image  from '../component/image.js';
import DivById from '../component/divById.js';
import P from '../component/text.js';
import Input from '../component/input.js';
import Textarea from '../component/textarea.js';
import Div from '../component/div.js';
import Form from '../component/form.js';
import Label from '../component/label.js';
import MesssageWindow from '../model/message.js';


export default class Home {
  constructor(controller) {
    this.controller = controller;
    this.app = $('#app');
    this.title = P(`광훈이에게 ${localStorage['age']}살의 나이를 멕였습니다.`);
    // this.title.style.fontSize='1.2em';
    this.soupImage = Image(controller.soup,'500px');
    this.gomyeong = Image('assets/food.png','120px');
    this.gomyeong.setAttribute('draggable','false');
    this.gomyeong.setAttribute('style',
      `
      position: absolute;
      margin-left: auto;
      margin-right: auto;
      left: 0;
      right: 0;
      top: 41%;
      text-align: center;
      z-index:${1}
      `
    );
    this.app.append(Div([this.title, this.soupImage,this.gomyeong]));
    this.nickname = Input('닉네임');
    this.message = Textarea();
    let form = Form([Div([Label('name','닉네임: '),this.nickname]),Div([Label('message','축하 메세지: '), this.message])])
    this.app.append(form);
    this.buttonImage = Div([Image('/assets/button.png','50px')]);
    this.tteokDiv = Div([]);
    this.msgDiv = Div([]);
    this.app.append(Div([this.buttonImage]));
    this.app.append(this.tteokDiv, this.msgDiv);
  
    this.buttonHandler(controller);
    this.putAllTteoks();
    this.mouseState = false;
    // this.tteoks = this.controller.tteoks;
  }

  buttonHandler() {
    this.buttonImage.addEventListener('click', e => {
      e.preventDefault();
      this.controller.addTteok(this.nickname.value, this.message.value);
      this.putOneTteok(localStorage['age']-1);
    });
  }

  putAllTteoks(){
    const tteoks = this.controller.tteoks;
    for(let i=0; i<tteoks.length; i++){
      this.setTteok(i);
    }
  }

  putOneTteok(id){
    this.setTteok(id);
    if(id<22){
      this.controller.moreSoup();
      this.soupImage.setAttribute('src', this.controller.soup);
    }
    this.title.innerHTML = `광훈이에게 ${localStorage['age']}살의 나이를 멕였습니다.`;
  }

  removeAllTteoks(){
    this.tteokDiv.remove();
    this.tteokDiv = Div([]);
    this.app.append(this.tteokDiv);
    this.putAllTteoks();
  }

  removeOneTteok(id){
    document.getElementById(`tteok-${id}`).outerHTML="";
    document.getElementById(`msg-${id}`).outerHTML="";
  }

  setMessageDialog(id){
    const name = this.controller.tteoks[id].name;
    const msg = this.controller.tteoks[id].message;
    const top = this.controller.tteoks[id].top;
    const left = this.controller.tteoks[id].left;
    return MesssageWindow(name, msg, top, left,id);
  }

  setTteok(id){
    const tteoks = this.controller.tteoks;
    let tteok = DivById([Image('/assets/tteok.png','100px')],`tteok-${id}`);
    let msgWindow = this.setMessageDialog(id);

    tteok.setAttribute('style', `position:absolute; top:${10+tteoks[id].top}px; left:${10+tteoks[id].left}px; z-index:${id+1}`);

    tteok.addEventListener('mousedown', e =>{
      console.log('mousedown');
      let x = this.controller.tteoks[id].left;
      let y = this.controller.tteoks[id].top;
      console.log(`${x}, ${y}`);
      tteok.style.left = e.clientX - x;
      tteok.style.top = e.clientY - y;
      this.mouseState = true;
      this.controller.startMove(id,e.clientX - x, e.clientY - y);
    });
    
    tteok.addEventListener('dragend', e =>{
      if(msgWindow.style.display === 'none' && this.mouseState === true){
        let x = this.controller.tteoks[id].left;
        let y = this.controller.tteoks[id].top;
        this.controller.moved(id,e.clientX - x,e.clientY - y);
        this.mouseState = false;
        this.removeOneTteok(id);
        this.putOneTteok(id);
      }
    });

    tteok.addEventListener('click', e =>{
      this.mouseState = false;
      if(msgWindow.style.display === 'block'){
        msgWindow.style.display = 'none'
      }else{
        msgWindow.style.display = 'block'
      }
    });

    this.tteokDiv.append(tteok);
    this.msgDiv.append(msgWindow);
  }

  setGomyeong(){
    this.gomyeong.setAttribute('style',
      `
      position: absolute;
      margin-left: auto;
      margin-right: auto;
      left: 0;
      right: 0;
      text-align: center;
      z-index:${id+1}
      `
    );
  }
}