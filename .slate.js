var hyper = ":ctrl;cmd;shift;alt";

// To be inserted.
var bindings = {};
// ~~ Aesthetic offsets ~~
var gxo = "0";
var gyo = "30"; // We use this because we have some bars on top. Ubersicht.
var xo = "14";
var yo = "0";

// ~~ Screen variables ~~
// Origins
var sox = "screenOriginX+"+gxo+"+"+xo+"/2";
var soy = "screenOriginY+"+gyo+"+"+yo+"/2";
// Size
var ssx = "screenSizeX";
var ssy = "screenSizeY";

var generate_dir = function(ox, oy,
                            sx, sy){
    return S.op("move", {
                "x": ox,
                "y": oy,
                "width": sx,
                "height": sy
    });
};

var full        = generate_dir(sox, soy, ssx+"-"+xo, ssy+"-"+yo+"-"+gyo+"/2");
var lefthalf    = generate_dir(sox, soy, ssx+"/2"+"-"+xo, ssy+"-"+yo+"-"+gyo+"/2");
var topleft     = generate_dir(sox, soy, ssx+"/2"+"-"+xo, ssy+"/2-"+yo+"-"+gyo+"/2");
var tophalf     = generate_dir(sox, soy, ssx+"-"+xo, ssy+"/2-"+yo+"-"+gyo+"/2");
var topright    = generate_dir(sox+"+"+ssx+"/2", soy, ssx+"/2-"+xo, ssy+"/2-"+yo+"-"+gyo+"/2");
var righthalf   = generate_dir(sox+"+"+ssx+"/2", soy, ssx+"/2-"+xo, ssy+"-"+yo+"-"+gyo+"/2");
var bottomright = generate_dir(sox+"+"+ssx+"/2", soy+"+"+ssy+"/2-"+gyo+"/2", ssx+"/2-"+xo, ssy+"/2-"+yo+"-"+gyo+"/2");
var bottomhalf  = generate_dir(sox, soy+"+"+ssy+"/2-"+gyo+"/2", ssx+"-"+xo, ssy+"/2-"+yo+"-"+gyo+"/2");
var bottomleft  = generate_dir(sox, soy+"+"+ssy+"/2-"+gyo+"/2", ssx+"/2-"+xo, ssy+"/2-"+yo+"-"+gyo+"/2");
var leftthird   = generate_dir(sox, soy, ssx+"/3"+"-"+xo, ssy+"-"+yo+"-"+gyo+"/2");
var lefttwothird = generate_dir(sox, soy, ssx+"*2/3"+"-"+xo, ssy+"-"+yo+"-"+gyo+"/2");
var rightthird = generate_dir(sox+"+"+ssx+"*2/3", soy, ssx+"/3"+"-"+xo, ssy+"-"+yo+"-"+gyo+"/2");
var righttwothird = generate_dir(sox+"+"+ssx+"/3", soy, ssx+"*2/3"+"-"+xo, ssy+"-"+yo+"-"+gyo+"/2");
// ~~ Window Directions ~~
// ddict = direction dict, bdict = binddict, postpend = hyper.
var bind_dir = function(ddict, bdict, postpend){
    let dirs = Object.keys(ddict);
    for(var i = 0; i < dirs.length; i++){
        let str = dirs[i];
        let dir = ddict[str];
        bdict[str+postpend] = dir;
    }
};

var directions = {
    's' : full, 
    'a' : lefthalf, 
    'q' : topleft, 
    'w' : tophalf, 
    'e' : topright,
    'd' : righthalf,
    'c' : bottomright,
    'x' : bottomhalf,
    'z' : bottomleft,
    '1' : leftthird,
    '2' : righttwothird,
};

// ~~ Directional focus ~~
var bind_focus_dir = function(ddict, bdict, postpend){
    let dirs = Object.keys(ddict);
    for(var i = 0; i < dirs.length; i++){
        let str = dirs[i];
        let dir = ddict[str];
        bdict[str+postpend] = S.op("focus", {"direction" : dir});
    }
};

var focus_dir = {
    'l' : 'right',
    'k' : 'down',
    'j' : 'up',
    'h' : 'left',
};

// ~~ Application Focus ~~
var bind_focus_app = function(adict, bdict, postpend){
    let apps = Object.keys(adict);
    for(var i = 0; i < apps.length; i++){
        let str = apps[i];
        let app = adict[str];
        bdict[str+postpend] = S.op("focus", {"app" : app});
    }
};

var apps = {
    'b' : 'Google Chrome',
    't' : 'iTerm2',
    'f' : 'Finder',
    'p' : 'Preview',
};

// ~~ Window Resizing ~~
var bind_resize = function(ddict, bdict, postpend){
    let dirs = Object.keys(ddict);
    for(var i = 0; i < dirs.length; i++){
        let str = dirs[i];
        let dir = ddict[str];
        bdict[str+postpend] = S.op("resize", dir);
    }
}

var resize_dir = {
    "left": { 
    "width" : "-5%",
    "height" : "+0"
    },
    "right": {
    "width" : "+5%",
    "height" : "+0"
    },
    "up": {
    "width" : "+0",
    "height" : "-5%"
    },
    "down": {
    "width" : "+0",
    "height" : "+5%"
    },  
}

// ~~ Stateful snapping ~~
// Store current window states.
var windowStates = {};

// Closure for state swapping for both right and left.
function getCycleStates(states) {
    return function(win) {
        if (win.pid in windowStates &&
            windowStates[win.pid] !== undefined &&
            states.indexOf(windowStates[win.pid]) !== -1
           ) {
            var nextIndex = (states.indexOf(windowStates[win.pid]) + 1) % 3;
            var nextState = states[nextIndex];
            windowStates[win.pid] = nextState;
        } else {
            windowStates[win.pid] = states[0];
        }

        eval(windowStates[win.pid] + '.run()');
    };
}

// Window cycling functions.
var leftCycleOp = getCycleStates(['leftthird',
                                  'lefttwothird',
                                  'full']);
var rightCycleOp = getCycleStates(['rightthird',
                                   'righttwothird',
                                   'full']);

bindings[',:cmd,shift'] = leftCycleOp;
bindings['.:cmd,shift'] = rightCycleOp;

bind_dir(directions, bindings, hyper);
bind_focus_dir(focus_dir, bindings, hyper);
bind_focus_app(apps, bindings, hyper);
bind_resize(resize_dir, bindings, hyper);
// ~~~
S.bnda(bindings);
