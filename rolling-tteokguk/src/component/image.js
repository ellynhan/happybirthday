const Image = (src,height) => {
    const image = document.createElement('img');
    image.setAttribute('src', src);
    image.setAttribute('height',height);
    return image;
  };

  export default Image;