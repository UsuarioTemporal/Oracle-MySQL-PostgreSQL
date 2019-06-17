let images = ['./img/img_1.jpg','./img/img_2.jpg','./img/img_3.jpg']
let index = 0
const slider = container=> {
    container.addEventListener('click',e=>{
        let back= container.querySelector('.back'),
            next = container.querySelector('.next'),
            img = container.querySelector('img')
            target = e.target
        
        if (target===back){
            index= index===0 ? images.length-1 : index-1
        }else if(target===next){
            index= index===images.length-1 ? 0: index+1
        }
        image.src =images[index]
    })
}