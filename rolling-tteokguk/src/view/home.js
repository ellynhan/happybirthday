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
    this.buttonImage = Div([Image('/assets/button.png','50px')]);
    this.tteokDiv = Div([]);

    this.app.append(Div([this.buttonImage]));
    this.app.append(this.tteokDiv);
  
    this.buttonHandler(controller);
    this.putAllTteoks();
    this.mouseState = false;
  }

  buttonHandler() {
    this.buttonImage.addEventListener('click', e => {
      e.preventDefault();
      this.controller.addTteok(this.nickname.value, this.message.value);
    });
  }

  putAllTteoks(){
    const tteoks = this.controller.tteoks;
    for(let i=0; i<tteoks.length; i++){
      let image = Div([Image('/assets/ricecake2.png','100px')]);
      let msgWindow = this.setMessageDialog(i);
      image.setAttribute('style', `position:absolute; top:${tteoks[i].top}px; left:${tteoks[i].left}px; z-index:${i+1}`);
      image.addEventListener('mousedown', e =>{
        console.log('mousedown');
        let x = this.controller.tteoks[i].left;
        let y = this.controller.tteoks[i].top;
        image.style.left = e.clientX - x;
        image.style.top = e.clientY - y;
        this.mouseState = true;
        this.controller.startMove(i,e.clientX - x, e.clientY - y);
      });
      
      image.addEventListener('dragend', e =>{
        if(msgWindow.style.display === 'none' && this.mouseState === true){
          let x = this.controller.tteoks[i].left;
          let y = this.controller.tteoks[i].top;
          this.controller.moved(i,e.clientX - x,e.clientY - y);
          this.mouseState = false;
          this.removeTteoks();
        }
      });

      this.tteokDiv.append(msgWindow);

      image.addEventListener('click', e =>{
        this.mouseState = false;
        if(msgWindow.style.display === 'block'){
          msgWindow.style.display = 'none'
        }else{
          msgWindow.style.display = 'block'
        }
        console.log('hi');
      });

      this.tteokDiv.append(image);
    }
  }

  putOneTteok(){
    const tteoks = this.controller.tteoks;
  }

  removeAllTteoks(){
    this.tteokDiv.remove();
    this.tteokDiv = Div([]);
    this.app.append(this.tteokDiv);
    this.putAllTteoks();
  }

  removeOneTteok(){

  }

  setMessageDialog(id){
    const name = this.controller.tteoks[id].name;
    const msg = this.controller.tteoks[id].message;
    const top = this.controller.tteoks[id].top;
    const left = this.controller.tteoks[id].left;
    return MesssageWindow(name, msg, top, left);
  }
}