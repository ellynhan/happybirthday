const DivByName = (children, className) => {
    const div = document.createElement('div');
    div.setAttribute('class',className);
    children.forEach((child)=>{
        div.append(child); 
      } 
    )
    return div;
  };
  
export default DivByName;