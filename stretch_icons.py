import matplotlib.pyplot as plt
import matplotlib.patches as patches

# Function to create icon
# mode = 'uniaxial' or 'biaxial'
def create_icon(mode, filename):
    fig, ax = plt.subplots(figsize=(2,2))
    ax.set_xlim(0, 1)
    ax.set_ylim(0, 1)
    ax.axis('off')

    # Draw rectangle (sample)
    rect = patches.Rectangle((0.3, 0.3), 0.4, 0.4, linewidth=2, edgecolor='black', facecolor='none')
    ax.add_patch(rect)

    if mode == 'uniaxial':
        # Horizontal arrows only
        ax.annotate('', xy=(0.25, 0.5), xytext=(0.05, 0.5),
                    arrowprops=dict(facecolor='black', arrowstyle='->', lw=2))
        ax.annotate('', xy=(0.75, 0.5), xytext=(0.95, 0.5),
                    arrowprops=dict(facecolor='black', arrowstyle='->', lw=2))

    elif mode == 'biaxial':
        # Horizontal arrows
        ax.annotate('', xy=(0.25, 0.5), xytext=(0.05, 0.5),
                    arrowprops=dict(facecolor='black', arrowstyle='->', lw=2))
        ax.annotate('', xy=(0.75, 0.5), xytext=(0.95, 0.5),
                    arrowprops=dict(facecolor='black', arrowstyle='->', lw=2))
        # Vertical arrows
        ax.annotate('', xy=(0.5, 0.75), xytext=(0.5, 0.95),
                    arrowprops=dict(facecolor='black', arrowstyle='->', lw=2))
        ax.annotate('', xy=(0.5, 0.25), xytext=(0.5, 0.05),
                    arrowprops=dict(facecolor='black', arrowstyle='->', lw=2))

    plt.savefig(filename, dpi=300, transparent=True, bbox_inches='tight')
    plt.close()

# Create icons
create_icon('uniaxial', 'icon_uniaxial.png')
create_icon('biaxial', 'icon_biaxial.png')
