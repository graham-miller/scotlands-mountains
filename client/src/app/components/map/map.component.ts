import { Component, Input } from '@angular/core';
import { latLng, tileLayer, marker, icon, layerGroup } from 'leaflet';
import { Mountain } from 'src/app/models/Mountain';

@Component({
  selector: 'app-map',
  templateUrl: './map.component.html',
  styleUrls: ['./map.component.css']
})
export class MapComponent {

  private markers = layerGroup();
  private icon = icon({
    iconSize: [ 25, 41 ],
    iconAnchor: [ 13, 41 ],
    iconUrl: 'assets/marker-icon.png',
    shadowUrl: 'assets/marker-shadow.png'
  })

  options = {
    layers: [
      tileLayer('http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', { maxZoom: 18, attribution: '...' }),
      this.markers
    ],
    zoom: 7,
    center: latLng(56.659406, -4.011214)
  };

  @Input()
  set mountains(mountains: Mountain[]){
    this.markers.clearLayers();
    mountains.forEach(m => this.markers.addLayer(marker([m.latitude, m.longitude], { icon: this.icon })));
  }
}
