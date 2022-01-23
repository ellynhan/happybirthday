import { $ } from '../utils/selector.js';
import Image  from '../component/image.js';
import Button from '../component/button.js';
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
    this.app.append(Div([P(`광훈이에게 ${localStorage['age']}살의 나이를 멕였습니다.`)]));
    this.app.append(Div([Image('/assets/soup1.png','500px')]));
    this.nickname = Input('닉네임');
    this.message = Textarea();
    let form = Form([Div([Label('name','닉네임: '),this.nickname]),Div([Label('message','축하 메세지: '), this.message])])
    this.app.append(form);
    this.button = Button('나이 멕이기');
    this.dduckDiv = Div([]);

    this.app.append(Div([this.button]));
    this.app.append(this.dduckDiv);
  
    this.buttonHandler(controller);
    this.putAllRicecakes();
    this.mouseState = false;
  }

  buttonHandler() {
    this.button.addEventListener('click', e => {
      e.preventDefault();
      this.controller.addRicecake(this.nickname.value, this.message.value);
    });
  }

  putAllRicecakes(){
    const dducks = this.controller.ricecakes;
    for(let i=0; i<dducks.length; i++){
      let image = Div([Image('/assets/ricecake2.png','100px')]);
      let msgWindow = this.setMessageDialog(i);
      image.setAttribute('style', `position:absolute; top:${dducks[i].top}px; left:${dducks[i].left}px; z-index:${i+1}`);
      image.addEventListener('mousedown', e =>{
        console.log('mousedown');
        let x = this.controller.ricecakes[i].left;
        let y = this.controller.ricecakes[i].top;
        image.style.left = e.clientX - x;
        image.style.top = e.clientY - y;
        this.mouseState = true;
        this.controller.startMove(i,e.clientX - x, e.clientY - y);
      });
      
      image.addEventListener('dragend', e =>{
        if(msgWindow.style.display === 'none' && this.mouseState === true){
          let x = this.controller.ricecakes[i].left;
          let y = this.controller.ricecakes[i].top;
          this.controller.moved(i,e.clientX - x,e.clientY - y);
          this.mouseState = false;
          this.removeRicecakes();
        }
      });

      this.dduckDiv.append(msgWindow);

      image.addEventListener('click', e =>{
        this.mouseState = false;
        if(msgWindow.style.display === 'block'){
          msgWindow.style.display = 'none'
        }else{
          msgWindow.style.display = 'block'
        }
        console.log('hi');
      });

      this.dduckDiv.append(image);
    }
  }

  removeRicecakes(){
    this.dduckDiv.remove();
    this.dduckDiv = Div([]);
    this.app.append(this.dduckDiv);
    this.putAllRicecakes();
  }

  setMessageDialog(id){
    const name = this.controller.ricecakes[id].name;
    const msg = this.controller.ricecakes[id].message;
    const top = this.controller.ricecakes[id].top;
    const left = this.controller.ricecakes[id].left;
    return MesssageWindow(name, msg, top, left);
  }
}