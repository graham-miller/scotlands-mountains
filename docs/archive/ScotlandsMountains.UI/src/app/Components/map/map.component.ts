import { AfterViewInit, Component, ElementRef, Input, OnChanges, OnDestroy, SimpleChanges } from '@angular/core';
import { Mountain } from '../../Models/Mountain';
import { MapService } from '../../Services/Map.service';
import { MountainMarkerService } from '../../Services/MountainMarker.service';

@Component({
    selector: 'app-map',
    template: '<div id="map"></div>',
    styleUrls: ['./map.component.scss']
})
export class MapComponent implements AfterViewInit, OnDestroy, OnChanges {

  @Input()mountains: Mountain[] = [];
  
  map?: L.Map | undefined;

  private markers = this.mountainMarkerService.createMarkerLayer();
  private clusteredMarkers = this.mountainMarkerService.createMarkerClusterLayer();

  constructor(
    private mapService: MapService,
    private mountainMarkerService: MountainMarkerService,
    private elementRef: ElementRef
  ) { }
  
  ngAfterViewInit(): void {
    this.map = this.mapService.createMap('map', [this.markers, this.clusteredMarkers]);
    this.addMountainsToMap();
  }

  ngOnChanges(): void {
    this.addMountainsToMap();
  }

  ngOnDestroy() {
    if (this.map) {
      this.mapService.destroyMap(this.map, this.elementRef.nativeElement.innerHTML);
    }
  }

  private addMountainsToMap() {
    this.removeMountainsFromMap();
    if (this.map) {
      const group = this.mountains.length > 300 ? this.clusteredMarkers : this.markers;
      this.mountains.forEach((m, i) => group.addLayer(this.mountainMarkerService.getMarker(m, -i)));
      if (this.mountains.length === 0) {
        this.map.flyTo(this.mapService.defaultCenter, this.mapService.defaultZoom, {duration:0.5});
      } else if (this.mountains.length === 1) {
        this.map.flyTo([this.mountains[0].location.coordinates[1], this.mountains[0].location.coordinates[0]], 13, {duration:0.5});
      } else {
        this.map.flyToBounds(this.getBounds(), {duration:0.5});
      }
    }
  }

  getBounds(): L.LatLngBoundsExpression {
    let minLat: number = 90;
    let maxLat: number = -90;
    let minLng: number = 180;
    let maxLng: number = -180;

    this.mountains.forEach(m => {
        minLat = m.location.coordinates[1] < minLat ? m.location.coordinates[1] : minLat;
        maxLat = m.location.coordinates[1] > maxLat ? m.location.coordinates[1] : maxLat;
        minLng = m.location.coordinates[0] < minLng ? m.location.coordinates[0] : minLng;
        maxLng = m.location.coordinates[0] > maxLng ? m.location.coordinates[0] : maxLng;
    })

    return [[minLat, minLng], [maxLat, maxLng]]
}

  private removeMountainsFromMap() {
    this.markers.clearLayers();
    this.clusteredMarkers.clearLayers();
  }
}
