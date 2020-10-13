import { AfterViewInit, Component, Input } from '@angular/core';
import * as L from 'leaflet';
import 'leaflet.markercluster';

import { Mountain } from 'src/app/models/Mountain';

L.Marker.prototype.options.icon = L.divIcon({ className: 'mountain-marker' });

@Component({
  selector: 'app-map',
  templateUrl: './map.component.html',
  styleUrls: ['./map.component.css']
})
export class MapComponent implements AfterViewInit {
  private map: L.Map;
  private clusteredMarkers = L.markerClusterGroup({
    iconCreateFunction: cluster => {
      return L.divIcon({ html: '<div class="clustered-mountain-marker"><div>+<div></div>' });
    }
  });
  private markers = L.layerGroup();

  ngAfterViewInit(): void {
    this.initMap();
  }

  @Input()
  set mountains(mountains: Mountain[]) {
    this.markers.clearLayers();
    this.clusteredMarkers.clearLayers();
    if (mountains) {
      const group: L.LayerGroup = mountains.length > 300 ? this.clusteredMarkers : this.markers;
      mountains.forEach((m, i) => {
        group.addLayer(L.marker([m.latitude, m.longitude], { zIndexOffset: -i }))
      });
      this.map.flyToBounds(this.getBounds(mountains));
    }
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
    this.clusteredMarkers.addTo(this.map);
  }

  getBounds(mountains: Mountain[]): L.LatLngBoundsExpression {
    let minLat: number = 90;
    let maxLat: number = -90;
    let minLng: number = 180;
    let maxLng: number = -180;

    mountains.forEach(m => {
      minLat = m.latitude < minLat ? m.latitude : minLat;
      maxLat = m.latitude > maxLat ? m.latitude : maxLat;
      minLng = m.longitude < minLng ? m.longitude : minLng;
      maxLng = m.longitude > maxLng ? m.longitude : maxLng;
    })

    return [[minLat, minLng], [maxLat, maxLng]]
  }
}
