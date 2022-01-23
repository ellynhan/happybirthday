import Tteok from "../model/tteok.js";

export class Controller {
  constructor() {
    this.age = 0;
    this.tteoks = [];
    this.soup = '/assets/soup1.png';
    this.setup();
  }

  setup(){
    if(localStorage.getItem('age') === null){
      localStorage['age'] = 0;
    }
    
    if(localStorage.getItem('tteoks') !== null){
      this.age = Number(localStorage['age']);
      this.tteoks = JSON.parse(localStorage['tteoks']);
      this.moreSoup();
      console.log(this.tteoks);
    }
  }

  addTteok(name, message){
    this.age += 1;
    localStorage['age'] = this.age;
    this.tteoks.push(new Tteok(this.age,name,message,this.age*10,this.age*10));
    localStorage.setItem('tteoks', JSON.stringify(this.tteoks));
  }

  showMessageWindow(id){
    let arr = document.querySelectorAll('.message-window');
    let index = 0;
    arr.forEach((elem)=>{
      elem.style.display = 'none';
      if(id === index){
        elem.style.display = 'block';
      }
      index += 1;
    })
  }

  startMove(id, x, y){
    this.tteoks[id].left = x;
    this.tteoks[id].top = y;
  }

  moved(id, x, y){
    this.tteoks[id].left = x;
    this.tteoks[id].top = y;
    localStorage.setItem('tteoks', JSON.stringify(this.tteoks));
  }

  moreSoup(){
    if(this.age <= 5){
      this.soup = '/assets/soup1.png';
    }else if(this.age <= 10){
      this.soup = '/assets/soup2.png';
    }else if(this.age <= 15){
      this.soup = '/assets/soup3.png';
    }else if(this.age <= 20){
      this.soup = '/assets/soup4.png';
    }else{
      this.soup = '/assets/soup5.png';
    }
  }

  checkValidation(name, message){
    if(name === undefined || !name.trim()){
      alert('올바르지 않은 이름입니다.');
      return false;
    }
    if(message === undefined || !message.trim()){
      alert('올바르지 않은 메세지 입니다.');
      return false;
    }
    return true;
  }
}
