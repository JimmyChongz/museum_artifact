class Artifact {
  final String id;
  final String name;
  final String category;
  final String size;
  final String era;
  final String description;

  Artifact({
    required this.id,
    required this.name,
    required this.category,
    required this.size,
    required this.era,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'size': size,
      'era': era,
      'description': description,
    };
  }
}

List<Artifact> artifacts = [];

void addArtifact(Artifact artifact) {
  artifacts.add(artifact);
}

List<Artifact> getArtifacts() {
  return artifacts;
}

void updateArtifact(String id, Artifact updatedArtifact) {
  for (int i = 0; i < artifacts.length; i++) {
    if (artifacts[i].id == id) {
      artifacts[i] = updatedArtifact;
      break;
    }
  }
}

void deleteArtifact(String id) {
  artifacts.removeWhere((artifact) => artifact.id == id);
}