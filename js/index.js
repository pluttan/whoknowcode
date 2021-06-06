var idc="canvas1"

function getBezierBasis(i, n, t) {
    // Факториал
    function f(n) {
        return (n <= 1) ? 1 : n * f(n - 1);
    }

    // считаем i-й элемент полинома Берштейна
    return (f(n) / (f(i) * f(n - i))) * Math.pow(t, i) * Math.pow(1 - t, n - i);
}

// arr - массив опорных точек. Точка - двухэлементный массив, (x = arr[0], y = arr[1])
// step - шаг при расчете кривой (0 < step < 1), по умолчанию 0.01. Чем больше шаг - тем грубее кривая
function getBezierCurve(arr, step) {
    if (step === undefined) {
        step = 0.01;
    }

    var res = [];

    step = step / arr.length;

    for (var t = 0.0; t < 1 + step; t += step) {
        if (t > 1) {
            t = 1;
        }

        var ind = res.length;

        res[ind] = new Array(0, 0);

        for (var i = 0; i < arr.length; i++) {
            var b = getBezierBasis(i, arr.length - 1, t);

            res[ind][0] += arr[i][0] * b;
            res[ind][1] += arr[i][1] * b;
        }
    }

    return res;
}

// Рисуем непрерывную кривую безье
// ctx - rendering context холста
// arr - массив точек по которым строим кривую
// delay - задержка перед отрисовкой следующей точки, pause - пауза перед началом  рисования,
function drawLines(ctx, arr, delay, pause) {
    if (delay === undefined) {
        delay = 20;
    }

    if (pause === undefined) {
        pause = delay;
    }
    var i = 0;

    function delayDraw() {
        if (i >= arr.length - 1) {
            return;
        }

        ctx.moveTo(arr[i][0], arr[i][1]);
        ctx.lineTo(arr[i + 1][0], arr[i + 1][1]);
        ctx.strokeStyle = '#000000';
        ctx.stroke();

        ++i;

        if (delay > 0) {
            setTimeout(delayDraw, delay);
        } else {
            delayDraw();
        }
    }

    if (pause > 0) {
        setTimeout(delayDraw, pause);
    } else {
        delayDraw();
    }
}

function drawPixels(ctx, arr, delay, pause) {
    if (delay === undefined) {
        delay = 10; 
    }

    if (pause === undefined) {
        pause = delay;
    }
    var i = 0;
    var pxl = ctx.createImageData(2, 2);
    var d = pxl.data; // only do this once per page
    d[0] = 0;
    d[1] = 0;
    d[2] = 0;
    d[3] = 255;

    function delayDraw() {
        if (i >= arr.length - 1) {
            return;
        }

        ctx.putImageData(pxl, arr[i][0], arr[i][1]);

        ++i;

        if (delay > 0) {
            setTimeout(delayDraw, delay);
        } else {
            delayDraw();
        }
    }

    if (pause > 0) {
        setTimeout(delayDraw, pause);
    } else {
        delayDraw();
    }
}

function drawPoints(ctx, arr, delay, pause) {
    if (delay === undefined) {
        delay = 0;
    }

    if (pause === undefined) {
        pause = delay;
    }

    var i = 0;

    function delayDraw() {

        ctx.beginPath();
        ctx.arc(arr[i][0], arr[i][1], pointRadius, 0, 2 * Math.PI);
        ctx.stroke();

        ctx.fillText((i + 1), arr[i][0], arr[i][1] - 10);

        ctx.fillStyle = '#000000';
        ctx.fillText(' (' + arr[i][0] + ', ' + arr[i][1] + ')', arr[i][0] + 15, arr[i][1] - 10);

        if (++i >= arr.length) {
            return;
        }

        if (delay > 0) {
            setTimeout(delayDraw, delay);
        } else {
            delayDraw();
        }
    }

    if (pause > 0) {
        setTimeout(delayDraw, pause);
    } else {
        delayDraw();
    }
}

drawC = document.getElementById(idc);

if (drawC && drawC.getContext) {
    ctx = drawC.getContext('2d');

    ctx.lineWidth = 0.1;

    var flow; // Массив точек
    var arr = new Array();
    
    arr[0] = new Array(0, 0);
    arr[1] = new Array(500, 0);
    flow = getBezierCurve(new Array(arr[0], arr[1]), 0.01);
    drawLines(ctx, flow, 10, 500);

    arr[1] = new Array(50,0);
    arr[2] = new Array(100,0);
    arr[3] = new Array(150,10);
    arr[4] = new Array(200,120);
    arr[5] = new Array(500,35);
    flow = getBezierCurve(new Array(arr[1],arr[2], arr[3],arr[4],arr[5]), 0.02);
    drawLines(ctx, flow, 10, 500);
}