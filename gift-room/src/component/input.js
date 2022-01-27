const Input = placeholder => {
  const input = document.createElement('input');
  input.setAttribute('placeholder', placeholder);
  return input;
};

export default Input;