const P = text => {
    const p = document.createElement('p');
    p.innerText = text;
    p.style.fontSize = '1.5em';
    p.style.margin = 0;
    return p;
  };
  
  export default P;