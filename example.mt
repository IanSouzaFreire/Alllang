/* Matte */

@:class = import(module:'Matte.Core.Class');

@:Vec2 = class(
  name : 'Vec2',
  statics : {
    none :: <- Vec2.some(),
    some ::(value) <- Vec2.new(value) 
  },
  
  define::(this) {
    @x;
    @y;
    
    this.constructor = ::(x_, y_) {
      x = x_;
      y = y_;
    };

    this.add = ::(x_, y_) {
      x += x_;
      y += y_;
    };

    this.scale = ::(scalar) {
      x = x * scalar;
      y = y * scalar;
    };

    this.interface = {
      map ::(
        some => Function, 
        none => Function
      ) {          
        when(value_ == empty) none();
        return some(value:value_);
      }    
    };
  }
)

@:Size = class(
  name : 'Size',
  statics : {
    none :: <- Size.some(),
    some ::(value) <- Size.new(value) 
  },
  
  define::(this) {
    @width;
    @height;
    
    this.constructor = ::(w, h) {
      width = w;
      height = h;
    };

    this.interface = {
      map ::(
        some => Function, 
        none => Function
      ) {          
        when(value_ == empty) none();
        return some(value:value_);
      }    
    };
  }
)

@:GameObject = class(
  name : 'GameObject',
  statics : {
    none :: <- GameObject.some(),
    some ::(value) <- GameObject.new(value) 
  },
  
  define::(this) {
    @position;
    @size;
    
    this.constructor = ::(pos, siz) {
      position = pos;
      size = siz;
    };

    this.interface = {
      map ::(
        some => Function, 
        none => Function
      ) {          
        when(value_ == empty) none();
        return some(value:value_);
      }    
    };
  }
)