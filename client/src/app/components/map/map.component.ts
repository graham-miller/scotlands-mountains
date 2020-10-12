import { AfterViewInit, Component, Input } from '@angular/core';
import * as L from 'leaflet';
import { Mountain } from 'src/app/models/Mountain';

const iconRetinaUrl = 'assets/marker-icon-2x.png';
const iconUrl = 'assets/marker-icon.png';
const shadowUrl = 'assets/marker-shadow.png';
const iconDefault = L.icon({
  iconRetinaUrl,
  iconUrl,
  shadowUrl,
  iconSize: [25, 41],
  iconAnchor: [12, 41],
  popupAnchor: [1, -34],
  tooltipAnchor: [16, -28],
  shadowSize: [41, 41]
});
L.Marker.prototype.options.icon = iconDefault;

@Component({
  selector: 'app-map',
  templateUrl: './map.component.html',
  styleUrls: ['./map.component.css']
})
export class MapComponent implements AfterViewInit {
  private map;
  private markers = L.layerGroup();

  ngAfterViewInit(): void {
    this.initMap();
  }

  @Input()
  set mountains(mountains: Mountain[]){
    this.markers.clearLayers();
    mountains.forEach(m => this.markers.addLayer(L.marker([m.latitude, m.longitude])));//, { icon: this.icon })));
  }

  private initMap(): void {
    const tiles = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 18,
      attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    });
    
    this.map = L.map('map', {
      center: [56.659406, -4.011214],
      zoom: 7
    });

    this.map.attributionControl.setPrefix('');
    tiles.addTo(this.map);
    this.markers.addTo(this.map);
  }
}
