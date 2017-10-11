//board.js
var geometry = new THREE.PlaneGeometry(100, 100);
var material = new THREE.MeshBasicMaterial({color: 0xffff00});
var floor = new THREE.Mesh(geometry, material);
var board = floor;
