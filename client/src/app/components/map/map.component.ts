import { AfterViewInit, Component, Input, ElementRef } from '@angular/core';
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
  template: '<div id="map"></div>',
  styleUrls: ['./map.component.css']
})
export class MapComponent implements AfterViewInit {
  private map: L.Map;
  private clusteredMarkers = L.markerClusterGroup({
    iconCreateFunction: () => {
      return L.divIcon({ html: '<div class="clustered-mountain-marker"><div>+<div></div>' });
    }
  });
  private markers = L.layerGroup();

  constructor(private metersToFeet: MetersToFeetPipe, private elementRef: ElementRef) { }

  @Input() set mountains(mountains: Mountain[]) {
    this.addMountainsToMap(mountains);
  }

  ngAfterViewInit(): void {
    this.initMap();
  }

  ngOnDestroy() {
    this.destroyMap();
  }

  private initMap(): void {
    this.map = L.map('map', {
      center: [56.659406, -4.011214],
      zoom: 7,
      gestureHandling: true
    } as L.MapOptions);

    this.addBaseLayers();
    this.addMapControls();
  }

  private addBaseLayers() {
    const outdoors = this.createThunderforestTileLayer('outdoors');
    const landscape = this.createThunderforestTileLayer('landscape');
    const transport = this.createThunderforestTileLayer('transport');
    const cycle = this.createThunderforestTileLayer('cycle');

    const baseLayers = {
      'Outdoors': outdoors,
      'Landscape': landscape,
      'Transport': transport,
      'Cycle': cycle
    };

    const markers = L.layerGroup([this.markers, this.clusteredMarkers]);

    L.control.layers(baseLayers, { 'Markers': markers }).addTo(this.map);

    outdoors.addTo(this.map);
    markers.addTo(this.map);
  }

  private createThunderforestTileLayer(moniker: string): L.TileLayer {
    return L.tileLayer(
      `https://tile.thunderforest.com/${moniker}/{z}/{x}/{y}.png?apikey=231e70bf20b64d8ca94199922441d3f7`,
      { maxZoom: 18 });
  }

  private addMapControls() {
    this.map.attributionControl.setPrefix('');

    L.control.scale({
      maxWidth: 200,
      metric: true,
      imperial: true,
      updateWhenIdle: false,
      position: 'bottomright'
    }).addTo(this.map);
  }

  private addMountainsToMap(mountains: Mountain[]) {
    this.removeMountainsFromMap();
    if (mountains) {
      const group: L.LayerGroup = mountains.length > 300 ? this.clusteredMarkers : this.markers;
      mountains.forEach((m, i) => group.addLayer(this.getMarker(m, -i)));
      this.map.flyToBounds(this.getBounds(mountains));
    }
  }

  private removeMountainsFromMap() {
    this.markers.clearLayers();
    this.clusteredMarkers.clearLayers();
  }

  private getMarker(mountain: Mountain, zIndex: number): L.Marker {
    let marker = L.marker([mountain.latitude, mountain.longitude], { zIndexOffset: zIndex });
    marker.on('mouseover', e => this.showPopup(e, mountain));
    marker.on('mouseout', e => this.hidePopup(e));
    marker.on('click', e => this.togglePopup(e, mountain));

    return marker;
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

  private destroyMap() {
    this.map.off();
    this.map.remove();
    this.map.getContainer().replaceWith(this.elementRef.nativeElement.innerHTML);
  }
}
