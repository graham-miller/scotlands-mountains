import { AfterViewInit, Component, Input } from '@angular/core';
import { formatNumber } from '@angular/common';
import * as L from 'leaflet';
import 'leaflet.markercluster';
import GestureHandling from 'leaflet-gesture-handling';

import { Mountain } from 'src/app/models/Mountain';
import { MetersToFeetPipe } from 'src/app/pipes/meters-to-feet.pipe';

L.Marker.prototype.options.icon = L.divIcon({ className: 'mountain-marker' });
L.Map.addInitHook("addHandler", "gestureHandling", GestureHandling);

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

  constructor(private metersToFeet: MetersToFeetPipe) { }

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
        let marker = L.marker([m.latitude, m.longitude], { zIndexOffset: -i });
        marker.on('mouseover', e => this.showPopup(e, m));
        marker.on('mouseout', e => this.hidePopup(e));
        marker.on('click', e => this.togglePopup(e, m));
        group.addLayer(marker)
      });
      this.map.flyToBounds(this.getBounds(mountains));
    }
  }

  private togglePopup(event: L.LeafletEvent, mountain: Mountain) {
    if (event.target.getPopup()) {
      this.hidePopup(event);
    } else {
      this.showPopup(event, mountain);
    }
  }

  private showPopup(event: L.LeafletEvent, mountain: Mountain) {
    event.target.bindPopup(this.getPopupText(mountain)).openPopup();
  }

  private hidePopup(event: L.LeafletEvent) {
    event.target.closePopup();
    event.target.unbindPopup();
  }

  private initMap(): void {
    const tiles = L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 18,
      attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    });

    this.map = L.map('map', {
      center: [56.659406, -4.011214],
      zoom: 7,
      gestureHandling: true
    } as L.MapOptions);

    this.map.attributionControl.setPrefix('');
    tiles.addTo(this.map);
    this.markers.addTo(this.map);
    this.clusteredMarkers.addTo(this.map);
  }

  private getPopupText(mountain: Mountain): string {
    const meters = formatNumber(mountain.height, 'en-GB', '1.0-0');
    const feet = formatNumber(this.metersToFeet.transform(mountain.height), 'en-GB', '1.0-0');
    return `<span>${mountain.name}<br/>${meters}m (${feet}ft)</span>`    
  }

  private getBounds(mountains: Mountain[]): L.LatLngBoundsExpression {
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
