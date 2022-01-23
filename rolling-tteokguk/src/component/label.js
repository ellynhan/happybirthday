const Label = (labelfor, text) => {
    const label = document.createElement('label');
    label.setAttribute('for', labelfor);
    label.innerText = text;
    return label;
  };
  
export default Label;