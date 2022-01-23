const Div = children => {
    const div = document.createElement('div');
    children.forEach((child)=>{
        div.append(child); 
      } 
    )
    return div;
  };
  
export default Div;