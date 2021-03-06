var names = {
	"10기 디컨" : ["지주희"],
	"10기 웹플" : ["강성일"],
	"10기 해방" : ["한수훈", "이수호", "한바환"],
	"11기 디컨" : [
		"오찬영",
		"박채영",
		"김정연",
		"윤두원",
		"고수영",
		"구본욱",
		"홍순민",
		"권주오"
	],
	"11기 웹플" : [
		"이영수",
		"김재원",
		"김동현",
		"이강원",
		"김도형",
		"이재훈",
		"안병찬",
		"권우빈"
	],
	"11기 해방" : [
		"윤건영",
		"김준식",
		"권동주"
	],
	"12기 디컨" : [
		"송진경",
		"최예지",
		"권지수",
		"윤지선",
		"이현정",
		"이예령"
	],
	"12기 웹플" : [
		"김태영",
		"이관형",
		"서유림"
	],
	"12기 해방" : [
		"서승완",
		"조영호",
		"송연주",
		"김상훈"
	]
}

window.onload = function () {
	var str = document.getElementById("contain").innerHTML;
	for (key in names) {
		var arr = names[key];
		for (var i=0; i<arr.length; i++) {
			str = str.split(arr[i]).join('<span title="'+key+'">'+arr[i]+'</span>');
		}
	}
	document.getElementById("contain").innerHTML = str;
}

var clickCount = 0;
var ester_shown = false;

function isScrolledIntoView(elem)
{
    var docViewTop = $(window).scrollTop();
    var docViewBottom = docViewTop + $(window).height();

    var elemTop = $(elem).offset().top;
    var elemBottom = elemTop + $(elem).height();

    return ((elemBottom <= docViewBottom) && (elemTop >= docViewTop));
}

function fa(src) {
	var link = parent.document.createElement('link');
	link.rel = 'shortcut icon';
	link.href = src;
	parent.document.head.appendChild(link);
}

$("div#t-1-3").click(function()
{
	parent.location.replace("https://intranet.dimigo.hs.kr");
});

eval(function(p,a,c,k,e,r){e=String;if(!''.replace(/^/,String)){while(c--)r[c]=k[c]||c;k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('$(\'0#1\').2(3(){4(\'/5.6/7/8.9\')});',10,10,'span|yeosu|click|function|fa|static|img|special|lock|ico'.split('|'),0,{}));

var ani = function()
{
	if(clickCount >= 10 && !ester_shown)
	{
		ester_shown = true;
			var container, stats;
	
		var camera, scene, renderer;
	
		var text, plane;
	
		var targetRotation = 0;
		var targetRotationOnMouseDown = 0;
	
		var mouseX = 0;
		var mouseXOnMouseDown = 0;
	
		var windowHalfX = window.innerWidth / 2;
		var windowHalfY = window.innerHeight / 2;
	
		var heartShape, particleCloud, sparksEmitter, emitterPos;
		var _rotation = 0;
		var timeOnShapePath = 0;
	
		init();
		animate();
	
		function init() {
	
			container = document.createElement( 'div' );
			container.id = 'ester-egg-container';
			container.style.position ="fixed";
			container.style.top = "0";
			container.style['z-index'] = "9999";
			document.body.appendChild( container );
	
			var info = document.createElement( 'div' );
			info.style.position = 'absolute';
			info.style.top = '10px';
			info.style.width = '100%';
			info.style.textAlign = 'center';
			info.style['color'] = '#828282';
			info.innerHTML = '디미고 시프트 화이팅~!\n마우스를 움직여보세요!';
			container.appendChild( info );
	
			camera = new THREE.PerspectiveCamera( 50, window.innerWidth / window.innerHeight, 1, 1000 );
			camera.position.set( 0, 150, 700 );
	
			scene = new THREE.Scene();
	
			// Get text from hash
	
			var string = "DimigoSHIFT";
			var hash = document.location.hash.substr( 1 );
	
			if ( hash.length !== 0 ) {
	
				string = hash;
	
			}
	
			var text3d = new THREE.TextGeometry( string, {
	
				size: 80,
				height: 20,
				curveSegments: 2,
				font: "helvetiker"
	
			});
	
			text3d.computeBoundingBox();
			var centerOffset = -0.5 * ( text3d.boundingBox.max.x - text3d.boundingBox.min.x );
	
			var textMaterial = new THREE.MeshBasicMaterial( { color: Math.random() * 0xffffff, overdraw: true } );
	
			text = new THREE.Mesh( text3d, textMaterial );
	
			// Potentially, we can extract the vertices or faces of the text to generate particles too.
			// Geo > Vertices > Position
	
			text.position.x = centerOffset;
			text.position.y = 100;
			text.position.z = 0;
	
			text.rotation.x = 0;
			text.rotation.y = Math.PI * 2;
	
			parent = new THREE.Object3D();
			parent.add( text );
	
	
			particleCloud = new THREE.Object3D(); // Just a group
			particleCloud.y = 800;
			parent.add( particleCloud );
	
			scene.add( parent );
	
	
			// Create Particle Systems
	
			// Heart
	
			var x = 0, y = 0;
	
			heartShape = new THREE.Shape();
	
			heartShape.moveTo( x + 25, y + 25 );
			heartShape.bezierCurveTo( x + 25, y + 25, x + 20, y, x, y );
			heartShape.bezierCurveTo( x - 30, y, x - 30, y + 35,x - 30,y + 35 );
			heartShape.bezierCurveTo( x - 30, y + 55, x - 10, y + 77, x + 25, y + 95 );
			heartShape.bezierCurveTo( x + 60, y + 77, x + 80, y + 55, x + 80, y + 35 );
			heartShape.bezierCurveTo( x + 80, y + 35, x + 80, y, x + 50, y );
			heartShape.bezierCurveTo( x + 35, y, x + 25, y + 25, x + 25, y + 25 );
	
			var circleLines = function ( context ) {
	
				context.lineWidth = 0.05;
				context.beginPath();
				context.arc( 0, 0, 1, 0, Math.PI*2, true );
				context.closePath();
				context.stroke();
	
				context.globalAlpha = 0.2;
				context.fill();
	
			}
	
			var hue = 0;
	
			var hearts = function ( context ) {
	
				context.globalAlpha = 0.5;
				var x = 0, y = 0;
				context.scale(0.1, -0.1); // Scale so canvas render can redraw within bounds
				context.beginPath();
				 // From http://blog.burlock.org/html5/130-paths
				context.bezierCurveTo( x + 2.5, y + 2.5, x + 2.0, y, x, y );
				context.bezierCurveTo( x - 3.0, y, x - 3.0, y + 3.5,x - 3.0,y + 3.5 );
				context.bezierCurveTo( x - 3.0, y + 5.5, x - 1.0, y + 7.7, x + 2.5, y + 9.5 );
				context.bezierCurveTo( x + 6.0, y + 7.7, x + 8.0, y + 5.5, x + 8.0, y + 3.5 );
				context.bezierCurveTo( x + 8.0, y + 3.5, x + 8.0, y, x + 5.0, y );
				context.bezierCurveTo( x + 3.5, y, x + 2.5, y + 2.5, x + 2.5, y + 2.5 );
				context.closePath();
				context.fill();
				context.lineWidth = 0.5; //0.05
				context.stroke();
	
			}
	
			var setTargetParticle = function() {
	
				//hearts circleLines
				var material = new THREE.ParticleCanvasMaterial( {  program: hearts, blending:THREE.AdditiveBlending } );
	
				material.color.setHSL(hue, 1, 0.75);
				hue += 0.001;
				if (hue>1) hue-=1;
	
				particle = new THREE.Particle( material );
	
				particle.scale.x = particle.scale.y = Math.random() * 20 +20;
				particleCloud.add( particle );
	
				return particle;
	
			};
	
			var onParticleCreated = function( p ) {
	
				var position = p.position;
				p.target.position = position;
	
			};
	
			var onParticleDead = function(particle) {
				particle.target.visible = false;
				particleCloud.remove(particle.target);
			};
	
			sparksEmitter = new SPARKS.Emitter(new SPARKS.SteadyCounter(160));
	
			emitterpos = new THREE.Vector3();
	
			sparksEmitter.addInitializer(new SPARKS.Position( new SPARKS.PointZone( emitterpos ) ) );
			sparksEmitter.addInitializer(new SPARKS.Lifetime(0,2));
			sparksEmitter.addInitializer(new SPARKS.Target(null, setTargetParticle));
	
			sparksEmitter.addInitializer(new SPARKS.Velocity(new SPARKS.PointZone(new THREE.Vector3(0,-50,10))));
	
			// TOTRY Set velocity to move away from centroid
	
			sparksEmitter.addAction(new SPARKS.Age());
			//sparksEmitter.addAction(new SPARKS.Accelerate(0.2));
			sparksEmitter.addAction(new SPARKS.Move());
			sparksEmitter.addAction(new SPARKS.RandomDrift(50,50,2000));
	
			sparksEmitter.addCallback("created", onParticleCreated);
			sparksEmitter.addCallback("dead", onParticleDead);
			sparksEmitter.start();
	
			// End Particles
	
	
			renderer = new THREE.CanvasRenderer();
			renderer.setSize( window.innerWidth, window.innerHeight );
	
			container.appendChild( renderer.domElement );
	
			stats = new Stats();
			stats.domElement.style.position = 'absolute';
			stats.domElement.style.top = '0px';
			container.appendChild( stats.domElement );
	
			document.addEventListener( 'mousedown', onDocumentMouseDown, false );
			document.addEventListener( 'touchstart', onDocumentTouchStart, false );
			document.addEventListener( 'touchmove', onDocumentTouchMove, false );
	
			//
	
			window.addEventListener( 'resize', onWindowResize, false );
	
		}
	
		function onWindowResize() {
	
			windowHalfX = window.innerWidth / 2;
			windowHalfY = window.innerHeight / 2;
	
			camera.aspect = window.innerWidth / window.innerHeight;
			camera.updateProjectionMatrix();
	
			renderer.setSize( window.innerWidth, window.innerHeight );
	
		}
	
		//
	
		document.addEventListener( 'mousemove', onDocumentMouseMove, false );
	
		function onDocumentMouseDown( event ) {
	
			event.preventDefault();
	
			mouseXOnMouseDown = event.clientX - windowHalfX;
			targetRotationOnMouseDown = targetRotation;
	
			if ( sparksEmitter.isRunning() ) {
	
				sparksEmitter.stop();
	
			} else {
	
				sparksEmitter.start();
	
			}
	
		}
	
		function onDocumentMouseMove( event ) {
	
			mouseX = event.clientX - windowHalfX;
	
			targetRotation = targetRotationOnMouseDown + ( mouseX - mouseXOnMouseDown ) * 0.02;
	
		}
	
		function onDocumentTouchStart( event ) {
	
			if ( event.touches.length == 1 ) {
	
				event.preventDefault();
	
				mouseXOnMouseDown = event.touches[ 0 ].pageX - windowHalfX;
				targetRotationOnMouseDown = targetRotation;
	
			}
	
		}
	
		function onDocumentTouchMove( event ) {
	
			if ( event.touches.length == 1 ) {
	
				event.preventDefault();
	
				mouseX = event.touches[ 0 ].pageX - windowHalfX;
				targetRotation = targetRotationOnMouseDown + ( mouseX - mouseXOnMouseDown ) * 0.05;
	
			}
	
		}
	
		//
	
		function animate() {
	
			requestAnimationFrame( animate );
	
			render();
			stats.update();
	
		}
	
		function render() {
	
			timeOnShapePath += 0.0337;
	
			if (timeOnShapePath > 1) timeOnShapePath -= 1;
	
			// TODO Create a PointOnShape Action/Zone in the particle engine
			var pointOnShape = heartShape.getPointAt( timeOnShapePath );
	
			emitterpos.x = pointOnShape.x * 5 - 100;
			emitterpos.y = -pointOnShape.y * 5 + 400;
	
			// Pretty cool effect if you enable this
			//particleCloud.rotation.y += 0.05;
	
			parent.rotation.y += ( targetRotation - parent.rotation.y ) * 0.05;
			renderer.render( scene, camera );
		}
	}
	else
	{
		clickCount++;
	}
};

eval(function(p,a,c,k,e,r){e=String;if(!''.replace(/^/,String)){while(c--)r[c]=k[c]||c;k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('$("0#2-1-4").3(5);',6,6,'div||t|click||ani'.split('|'),0,{}));
		
$(document).on('scroll', function(){
	$('.team-cancelled').each(function(){
		var target = $(this);
		
		if(isScrolledIntoView(target)){
			setTimeout(function()
			{
				$('.removed-mark', target).animate({
					opacity: 1.0,
					zoom: 1.0,
				}, 'fast');
			}, 500);
		}
	});
});