const DivByName = (children, id) => {
    const div = document.createElement('div');
    div.setAttribute('id',id);
    children.forEach((child)=>{
        div.append(child); 
      } 
    )
    return div;
  };
  
export default DivByName;