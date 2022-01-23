const Form = children => {
    const form = document.createElement('form');
    children.forEach((child)=>{
        form.append(child); 
      } 
    )
    return form;
  };
  
export default Form;