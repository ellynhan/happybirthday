import Div from "../component/div.js";
import DivByName from "../component/divByClass.js";
import P from "../component/text.js";

const MesssageWindow = (name, message, top, left,id) => {
    let messageWindow = DivByName([], 'message-window');
    messageWindow.setAttribute('style',
    `background-color:gold;
    width:100px;
    height:150px;
    display:none;
    position:absolute;
    top:${top+60}px;
    left:${left}px;
    z-index:${300};
    max-width: 250px;
    padding: 10px;
    word-break: break-all;
    `);
    messageWindow.setAttribute('id',`msg-${id}`);
    messageWindow.innerText = `${name}\n${message}`
    return messageWindow; 
}

export default MesssageWindow;

