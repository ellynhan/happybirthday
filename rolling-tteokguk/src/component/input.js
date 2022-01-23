const Input = placeholder => {
  const input = document.createElement('input');
  input.setAttribute('placeholder', placeholder);
  input.setAttribute('maxlength',6);
  return input;
};

export default Input;